//
//  LoginViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 4/8/21.
//

import Combine
import Environment
import Foundation
import Models
import Networking

final class LoginViewModel: ObservableObject {
    @Published var token: String? {
        didSet {
            appEnvironment.authToken = token
        }
    }
    var appEnvironment: AppEnvironment!
    let client = APIClient()
    var cancellables = Set<AnyCancellable>()

    func login(email: String, password: String) {
        let url = appEnvironment.backendEnvironment.url
        let body = [
            "email": email,
            "password": password
        ]
        let request = HTTPRequest(baseURL: url,
                                  path: "/auth/login",
                                  method: .POST,
                                  body: body,
                                  isAuthenticated: false)

        client.performRequest(request)
            .decode(type: AuthToken.self, decoder: JSONDecoder())
            .sink { result in
            } receiveValue: { token in
                self.token = token.token
            }
            .store(in: &cancellables)
    }

    func createAccount(email: String, password: String) {
        let url = appEnvironment.backendEnvironment.url
        let body = [
            "email": email,
            "password": password
        ]
        let request = HTTPRequest(baseURL: url,
                                  path: "/auth/create",
                                  method: .POST,
                                  body: body,
                                  isAuthenticated: false)

        client.performRequest(request)
            .decode(type: AuthToken.self, decoder: JSONDecoder())
            .sink { result in
            } receiveValue: { token in
                self.token = token.token
            }
            .store(in: &cancellables)
    }

    func areCredentialsValid(email: String, password: String) -> Bool {
        return email.count > 0 && password.count > 4
    }
}
