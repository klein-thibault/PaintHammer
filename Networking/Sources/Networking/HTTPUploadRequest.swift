//
//  HTTPUploadRequest.swift
//  
//
//  Created by Thibault Klein on 3/21/21.
//

import Foundation

public struct HTTPUploadRequest {
    public var url: URL
    public var method: HTTPMethod = .PUT
    public var queryParameters: [String: String]?
    public var headers: [String: String]?
    public var body: Data

    public init(url: URL,
                method: HTTPMethod = .PUT,
                queryParameters: [String : String]? = nil,
                headers: [String : String]? = nil,
                body: Data) {
        self.url = url
        self.method = method
        self.queryParameters = queryParameters
        self.headers = headers
        self.body = body
    }
}

extension HTTPUploadRequest {
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        request.httpBody = body

        return request
    }
}
