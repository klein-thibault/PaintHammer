import Environment
import Foundation

public struct HTTPRequest {
    public var baseURL: URL
    public var path: String
    public var method: HTTPMethod
    public var queryParameters: [String: String]?
    public var headers: [String: String]?
    public var body: [String: Any]?
    public var isAuthenticated: Bool
    public let environment: AppEnvironment

    public init(baseURL: URL,
                path: String,
                method: HTTPMethod,
                queryParameters: [String: String]? = nil,
                headers: [String: String]? = nil,
                body: [String: Any]? = nil,
                isAuthenticated: Bool,
                timeZone: TimeZone = TimeZone.current,
                environment: AppEnvironment = AppEnvironment()) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.headers = headers
        self.body = body
        self.isAuthenticated = isAuthenticated
        self.environment = environment
    }
}

extension HTTPRequest {
    var endpoint: URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return baseURL.appendingPathComponent(path)
        }

        components.path.append(path)
        let queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = queryItems
        return components.url ?? baseURL.appendingPathComponent(path)
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        if isAuthenticated, !environment.authToken.isEmpty {
            let bearerToken = "Bearer \(environment.authToken)"
            request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            let bodyData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = bodyData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
