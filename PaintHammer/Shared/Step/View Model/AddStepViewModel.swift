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

    func addStepToProject(projectId: UUID,
                          description: String,
                          image: PHImage?,
                          paint: Paint?) -> AnyPublisher<Project, Error> {
        return createStep(projectId: projectId, description: description, paint: paint)
            .flatMap { project -> AnyPublisher<Project, Error> in
                if let image = image {
                    return self.generateUploadURLForStep(project: project, image: image)
                        .flatMap { uploadURL in
                            return self.uploadImage(url: uploadURL.url, image: image)
                        }
                        .map { result  in
                            return project
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

    func uploadImage(url: URL, image: PHImage) -> AnyPublisher<Data, Error> {
        let imageData = image.jpegData(compressionQuality: 1.0)!
        let headers = [
            "Content-Disposition": "attachment; filename=photo",
            "Content-Type": "image/jpeg",
            "x-amz-acl": "public-read"
        ]
        let request = HTTPUploadRequest(url: url,
                                        method: .PUT,
                                        headers: headers,
                                        body: imageData)

        return client.upload(request)
            .eraseToAnyPublisher()
    }
}
