//
//  AddStepViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/16/21.
//

import Combine
import Environment
import Foundation
import Models
import Networking

final class AddStepViewModel: ObservableObject {
    let client = APIClient()
    var appEnvironment: AppEnvironment!

    func addStepToProject(projectId: UUID,
                          description: String,
                          image: PHImage?,
                          paint: Paint?) -> AnyPublisher<Project, Error> {
        let imageUploader = ImageUploader(appEnvironment: appEnvironment)
        return createStep(projectId: projectId, description: description, paint: paint)
            .flatMap { project -> AnyPublisher<Project, Error> in
                if let image = image {
                    return imageUploader.generateUploadURLForStep(project: project, image: image)
                        .flatMap { uploadURL in
                            return imageUploader.uploadImage(url: uploadURL.url, image: image)
                        }
                        // add delay to give enough time for AWS lambda to trigger
                        .delay(for: .seconds(3), scheduler: RunLoop.main)
                        .flatMap { _ in
                            return self.getProjectDataWithImage(project)
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
        let url = appEnvironment.backendEnvironment.url
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

    private func getProjectDataWithImage(_ project: Project, retryCount: Int = 0) -> AnyPublisher<Project, Error> {
        let url = appEnvironment.backendEnvironment.url
        let request = HTTPRequest(baseURL: url,
                                  path: "/projects/\(project.id.uuidString)",
                                  method: .GET,
                                  isAuthenticated: true)

        return client.performRequest(request)
            .decode(type: Project.self, decoder: JSONDecoder())
            .flatMap { project -> AnyPublisher<Project, Error> in
                // Image was not updated yet, retry the call
                if let lastStep = project.steps.last, lastStep.image == nil, retryCount < 20 {
                    let newCount = retryCount + 1
                    return self.getProjectDataWithImage(project, retryCount: newCount)
                        .debounce(for: 1, scheduler: RunLoop.main)
                        .eraseToAnyPublisher()
                }

                return Just(project)
                    .mapError { _ in PaintHammerError.invalidState }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
