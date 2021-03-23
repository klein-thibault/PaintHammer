//
//  AddStepViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/16/21.
//

import Combine
import Foundation
import Models
import Networking

final class AddStepViewModel: ObservableObject {
    let client = APIClient()
    let imageUploader = ImageUploader()

    func addStepToProject(projectId: UUID,
                          description: String,
                          image: PHImage?,
                          paint: Paint?) -> AnyPublisher<Project, Error> {
        return createStep(projectId: projectId, description: description, paint: paint)
            .flatMap { project -> AnyPublisher<Project, Error> in
                if let image = image {
                    return self.imageUploader.generateUploadURLForStep(project: project, image: image)
                        .flatMap { uploadURL in
                            return self.imageUploader.uploadImage(url: uploadURL.url, image: image)
                        }
                        // add delay to give enough time for AWS lambda to trigger
                        .delay(for: .seconds(3), scheduler: RunLoop.main)
                        .flatMap { _ in
                            return self.getProjectData(project)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Just(project)
                        .mapError { _ in PaintHammerError.invalidState }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func createStep(projectId: UUID,
                            description: String,
                            paint: Paint?) -> AnyPublisher<Project, Error> {
        let url = URL(string: "http://127.0.0.1:8080")!

        var body = ["description": description]
        if let paintId = paint?.id.uuidString {
            body["paintId"] = paintId
        }

        let request = HTTPRequest(baseURL: url,
                                  path: "/projects/\(projectId.uuidString)/steps",
                                  method: .POST,
                                  body: body,
                                  isAuthenticated: true)

        return client
            .performRequest(request)
            .decode(type: Project.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func generateUploadURLForStep(project: Project, image: PHImage) -> AnyPublisher<UploadImageURL, Error> {
        let url = URL(string: "http://127.0.0.1:8080")!
        let step = project.steps.last!
        let lastIndex = project.steps.count

        let body = [
            "name": "step-\(lastIndex)-image.jpeg",
            "type": "step",
            "id": step.id.uuidString
        ]

        let request = HTTPRequest(baseURL: url,
                                  path: "/images",
                                  method: .POST,
                                  body: body,
                                  isAuthenticated: true)

        return client
            .performRequest(request)
            .decode(type: UploadImageURL.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func getProjectData(_ project: Project) -> AnyPublisher<Project, Error> {
        let url = URL(string: "http://127.0.0.1:8080")!
        let request = HTTPRequest(baseURL: url,
                                  path: "/projects/\(project.id.uuidString)",
                                  method: .GET,
                                  isAuthenticated: true)

        return client.performRequest(request)
            .decode(type: Project.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
