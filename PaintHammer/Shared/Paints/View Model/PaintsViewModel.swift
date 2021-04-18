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
    @Published var paints: [Paint] = []
    var appEnvironment: AppEnvironment!
    var cancellables = Set<AnyCancellable>()
    let client = APIClient()

    func loadPaintsForBrand(_ brand: String) {
        let url = appEnvironment.backendEnvironment.url
        let request = HTTPRequest(baseURL: url,
                                  path: "/paints",
                                  method: .GET,
                                  queryParameters: ["brand": brand],
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
                self.paints = paints
            }
            .store(in: &cancellables)
    }
}
