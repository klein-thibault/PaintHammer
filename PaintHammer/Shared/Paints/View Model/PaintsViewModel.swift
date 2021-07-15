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
    lazy var client = {
        return APIClient(appEnvironment: self.appEnvironment)
    }()

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

    func filterPaints(by searchText: String) -> [Paint] {
        return searchText.isEmpty
            ? paints
            : paints.filter { $0.name.contains(searchText) }
    }
}
