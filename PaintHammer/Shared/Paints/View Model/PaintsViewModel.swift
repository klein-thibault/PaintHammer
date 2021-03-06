//
//  PaintsViewModel.swift
//  PaintHammer (iOS)
//
//  Created by Thibault Klein on 3/5/21.
//

import Combine
import Foundation
import Models
import Networking

final class PaintsViewModel: ObservableObject {
    @Published var availablePaints: [String: [Paint]] = [:]
    var cancellables = Set<AnyCancellable>()
    let client = APIClient()

    func loadAvailablePaints() {
        let url = URL(string: "http://127.0.0.1:8080")!
        let request = HTTPRequest(baseURL: url,
                                  path: "/paints",
                                  method: .GET,
                                  isAuthenticated: false)

        let cancellable = client
            .performRequest(request)
            .decode(type: [Paint].self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Error fetching paints: \(error)")

                case .finished:
                    break
                }
            } receiveValue: { paints in
                self.availablePaints = ["Citadel": paints]
            }


        cancellables.insert(cancellable)
    }
}
