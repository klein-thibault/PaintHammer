//
//  File.swift
//  
//
//  Created by Thibault Klein on 3/5/21.
//

import Combine
import Foundation

public struct APIClient {
    public init() { }

    public func performRequest(_ request: HTTPRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request.urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
