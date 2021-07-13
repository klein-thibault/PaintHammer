//
//  File.swift
//  
//
//  Created by Thibault Klein on 3/5/21.
//

import Combine
import Environment
import Foundation

public enum PaintHammerError: Error {
    case invalidState
    case apiError(reason: String)
}

public struct APIClient {
    private let appEnvironment: AppEnvironment

    public init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }

    public func performRequest(_ request: HTTPRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request.urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                if response.statusCode == 401 {
                    appEnvironment.authToken = ""
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
