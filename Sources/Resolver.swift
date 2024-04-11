import Foundation

public protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T
}

public extension Resolver {
    func resolve<T>() -> T {
        resolve(T.self)
    }
}
