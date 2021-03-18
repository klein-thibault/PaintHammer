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
                          image: String?,
                          paint: Paint?) -> AnyPublisher<Project, Error> {
        let url = URL(string: "http://127.0.0.1:8080")!

        var body = ["description": description]
        if let image = image {
            body["image"] = image
        }
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
}
