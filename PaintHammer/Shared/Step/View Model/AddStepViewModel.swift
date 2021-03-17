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
    @Published var project: Project

    var cancellables = Set<AnyCancellable>()
    let client = APIClient()

    init(project: Project) {
        self.project = project
    }

    func addStepToProject(description: String, image: String?, paint: Paint?) {
        let url = URL(string: "http://127.0.0.1:8080")!

        var body = ["description": description]
        if let image = image {
            body["image"] = image
        }
        if let paintId = paint?.id.uuidString {
            body["paintId"] = paintId
        }

        let request = HTTPRequest(baseURL: url,
                                  path: "/projects/\(project.id.uuidString)/steps",
                                  method: .POST,
                                  body: body,
                                  isAuthenticated: true)

        let cancellable = client
            .performRequest(request)
            .decode(type: Step.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Error fetching projects: \(error)")

                case .finished:
                    break
                }
            } receiveValue: { step in
                self.project.steps.append(step)
            }

        cancellables.insert(cancellable)
    }
}
