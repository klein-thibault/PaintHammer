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
            .tryMap { data, _ in
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
