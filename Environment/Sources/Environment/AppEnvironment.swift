import Combine
import Foundation
import LocalStore

public class AppEnvironment: ObservableObject {
    @LocalStore(key: "backendEnvironment", defaultValue: BackendEnvironment.local.rawValue)
    public var backendEnvironmentRaw: Int

    public var backendEnvironment: BackendEnvironment {
        return BackendEnvironment(rawValue: backendEnvironmentRaw) ?? .local
    }

    @LocalStore(key: "authToken", defaultValue: "")
    public var authToken: String

    public init() { }

    public var isLoggedIn: Bool {
        return !authToken.isEmpty
    }
}
