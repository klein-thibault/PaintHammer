//
//  File.swift
//  
//
//  Created by Thibault Klein on 3/5/21.
//

import Combine
import Foundation

public enum PaintHammerError: Error {
    case invalidState
    case apiError(reason: String)
}

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

    public func upload(_ request: HTTPUploadRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request.urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError { error in
                if let error = error as? PaintHammerError {
                    return error
                } else {
                    return PaintHammerError.apiError(reason: error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
