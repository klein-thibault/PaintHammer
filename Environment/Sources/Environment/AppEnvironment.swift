import Combine
import Foundation
import LocalStore

public class AppEnvironment: ObservableObject {
    @LocalStore(key: "backendEnvironment", defaultValue: .staging)
    public var backendEnvironment: BackendEnvironment

    public init() { }
}
