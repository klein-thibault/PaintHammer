//
//  ProjectViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/17/21.
//

import Combine
import Foundation
import Models
import Networking

final class ProjectViewModel {
    let client = APIClient()

    func deleteStep(step: Step, fromProject project: Project) -> AnyPublisher<Project, Error> {
        let url = URL(string: "http://127.0.0.1:8080")!

        let request = HTTPRequest(baseURL: url,
                                  path: "/projects/\(project.id.uuidString)/steps/\(step.id.uuidString)",
                                  method: .DELETE,
                                  isAuthenticated: true)

        return client
            .performRequest(request)
            .decode(type: Project.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
