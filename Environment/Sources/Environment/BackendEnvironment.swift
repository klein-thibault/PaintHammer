import Foundation

public enum BackendEnvironment {
    case local, staging, production

    public var url: URL {
        switch self {
        case .local:
            return URL(string: "http://127.0.0.1:8080")!
        case .staging, .production:
            return URL(string: "https://painthammer.herokuapp.com")!
        }
    }
}
