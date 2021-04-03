//
//  PaintsViewModel.swift
//  PaintHammer (iOS)
//
//  Created by Thibault Klein on 3/5/21.
//

import Combine
import Environment
import Foundation
import Models
import Networking

final class PaintsViewModel: ObservableObject {
    @Published var availablePaints: [String: [Paint]] = [:]
    var appEnvironment: AppEnvironment!
    var cancellables = Set<AnyCancellable>()
    let client = APIClient()

    func loadAvailablePaints() {
        let url = appEnvironment.backendEnvironment.url
        let request = HTTPRequest(baseURL: url,
                                  path: "/paints",
                                  method: .GET,
                                  isAuthenticated: false)

        client.performRequest(request)
            .decode(type: [Paint].self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Error fetching paints: \(error)")

                case .finished:
                    break
                }
            } receiveValue: { paints in
                let citadelPaints = paints.filter { $0.brand == "Citadel" }
                let scale75Paints = paints.filter { $0.brand == "Scale75" }
                self.availablePaints = ["Citadel": citadelPaints, "Scale75": scale75Paints]
            }
            .store(in: &cancellables)
    }
}
