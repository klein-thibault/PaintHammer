//
//  ProjectsListViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Combine
import Environment
import Foundation
import Models
import Networking

final class ProjectsListViewModel: ObservableObject {
    @Published var projects: [Project] = []
    var cancellables = Set<AnyCancellable>()
    var appEnvironment: AppEnvironment!
    let client = APIClient()

    func loadProjects() {
        self.fetchAllProjects()
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
            .store(in: &cancellables)
    }

    func deleteProject(_ project: Project, atIndex index: IndexSet.Element) {
        let url = appEnvironment.backendEnvironment.url
        let request = HTTPRequest(baseURL: url,
                                  path: "/projects/\(project.id.uuidString)",
                                  method: .DELETE,
                                  isAuthenticated: true)

        projects.remove(at: index)

        client.performRequest(request)
            .flatMap { _ in
                return self.fetchAllProjects()
            }
            .sink { result in

            } receiveValue: { projects in
                self.projects = projects
            }
            .store(in: &cancellables)
    }

    func createProject(name: String, image: PHImage?) -> AnyPublisher<[Project], Error> {
        let imageUploader = ImageUploader(appEnvironment: appEnvironment)

        return createProject(name: name)
            .flatMap { project -> AnyPublisher<[Project], Error> in
                if let image = image {
                    return imageUploader.generateUploadURLForProject(project: project, image: image)
                        .flatMap { uploadURL -> AnyPublisher<Data, Error> in
                            return imageUploader.uploadImage(url: uploadURL.url, image: image)
                        }
                        // add delay to give enough time for AWS lambda to trigger
                        .delay(for: .seconds(3), scheduler: RunLoop.main)
                        .flatMap { data -> AnyPublisher<[Project], Error> in
                            return self.fetchAllProjects()
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.fetchAllProjects()
                }
            }
            .eraseToAnyPublisher()
    }

    private func createProject(name: String) -> AnyPublisher<Project, Error> {
        let url = appEnvironment.backendEnvironment.url
        let body = ["name": name]

        let request = HTTPRequest(baseURL: url,
                                  path: "/projects",
                                  method: .POST,
                                  body: body,
                                  isAuthenticated: true)

        return client.performRequest(request)
            .decode(type: Project.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func fetchAllProjects() -> AnyPublisher<[Project], Error> {
        let url = appEnvironment.backendEnvironment.url
        let request = HTTPRequest(baseURL: url,
                                  path: "/projects",
                                  method: .GET,
                                  isAuthenticated: true)

        return client.performRequest(request)
            .decode(type: [Project].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
