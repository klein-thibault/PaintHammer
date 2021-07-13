//
//  ImageUploader.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/23/21.
//

import Combine
import Environment
import Foundation
import Models
import Networking

struct ImageUploader {
    let client: APIClient
    var appEnvironment: AppEnvironment

    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
        self.client = APIClient(appEnvironment: appEnvironment)
    }

    func generateUploadURLForProject(project: Project, image: PHImage) -> AnyPublisher<UploadImageURL, Error> {
        let body = [
            "name": "project-\(project.name)-image.jpeg",
            "type": "project",
            "id": project.id.uuidString
        ]

        return generateUploadURL(body: body)
    }

    func generateUploadURLForStep(project: Project, image: PHImage) -> AnyPublisher<UploadImageURL, Error> {
        let step = project.steps.last!
        let index = project.steps.count
        let body = [
            "name": "step-\(index)-image.jpeg",
            "type": "step",
            "id": step.id.uuidString
        ]

        return generateUploadURL(body: body)
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

    private func generateUploadURL(body: [String: Any]) -> AnyPublisher<UploadImageURL, Error> {
        let url = appEnvironment.backendEnvironment.url
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
}
