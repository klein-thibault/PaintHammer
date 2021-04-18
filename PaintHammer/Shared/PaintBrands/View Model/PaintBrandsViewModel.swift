//
//  PaintBrandsViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 4/17/21.
//

import Combine
import Environment
import Foundation
import Networking

final class PaintBrandsViewModel: ObservableObject {
    @Published var paintBrands: [String] = []
    var appEnvironment: AppEnvironment!
    var cancellables = Set<AnyCancellable>()
    let client = APIClient()

    func loadAllAvailablePaintBrands() {
        let url = appEnvironment.backendEnvironment.url
        let request = HTTPRequest(baseURL: url,
                                  path: "/paints/brands",
                                  method: .GET,
                                  isAuthenticated: false)

        client.performRequest(request)
            .decode(type: [String].self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Error fetching paint brands: \(error)")

                case .finished:
                    break
                }
            } receiveValue: { paintBrands in
                self.paintBrands = paintBrands
            }
            .store(in: &cancellables)
    }
}
