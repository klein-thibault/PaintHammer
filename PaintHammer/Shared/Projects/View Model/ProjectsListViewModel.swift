//
//  ProjectsListViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Combine
import Foundation
import Models
import Networking

final class ProjectsListViewModel: ObservableObject {
    @Published var projects: [Project] = []
    var cancellables = Set<AnyCancellable>()
    let client = APIClient()

    func loadProjects() {
        let url = URL(string: "http://127.0.0.1:8080")!
        let request = HTTPRequest(baseURL: url,
                                  path: "/projects",
                                  method: .GET,
                                  isAuthenticated: true)

        let cancellable = client
            .performRequest(request)
            .decode(type: [Project].self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Error fetching projects: \(error)")

                case .finished:
                    break
                }
            } receiveValue: { projects in
                self.projects = projects
            }

        cancellables.insert(cancellable)
    }
}
