import Foundation

@propertyWrapper
public struct LocalStore<T> {
    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults

    public var wrappedValue: T {
        get {
            return userDefaults.value(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.setValue(newValue, forKey: key)
            userDefaults.synchronize()
        }
    }

    public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
}
