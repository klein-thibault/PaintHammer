import Combine
import Foundation
import LocalStore

public class AppEnvironment: ObservableObject {
    @LocalStore(key: "backendEnvironment", defaultValue: .local)
    public var backendEnvironment: BackendEnvironment

    @LocalStore(key: "authToken", defaultValue: "")
    public var authToken: String

    public init() { }

    public var isLoggedIn: Bool {
        return !authToken.isEmpty
    }
}
