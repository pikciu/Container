import Foundation

public extension Container {
    
    @discardableResult
    func registerUnique<T>(factory: @escaping (Resolver) -> T) -> Registration<T> {
        registerUnique(T.self, factory: factory)
    }
    
    @discardableResult
    func registerShared<T>(factory: @escaping (Resolver) -> T) -> Registration<T> {
        registerShared(T.self, factory: factory)
    }
    
    @discardableResult
    func registerWeak<T>(factory: @escaping (Resolver) -> T) -> Registration<T> {
        registerWeak(T.self, factory: factory)
    }
    
    @discardableResult
    func registerUnique<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerUnique(type) { _ in
            factory()
        }
    }
    
    @discardableResult
    func registerShared<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerShared(type) { _ in
            factory()
        }
    }
    
    @discardableResult
    func registerWeak<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerWeak(type) { _ in
            factory()
        }
    }
    
    @discardableResult
    func registerUnique<T>(_ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerUnique(T.self, factory())
    }
    
    @discardableResult
    func registerShared<T>(_ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerShared(T.self, factory())
    }
    
    @discardableResult
    func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerWeak(T.self, factory())
    }
    
    @discardableResult
    static func registerUnique<T>(_ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerUnique(T.self, factory())
    }
    
    @discardableResult
    static func registerShared<T>(_ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerShared(T.self, factory())
    }
    
    @discardableResult
    static func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerWeak(T.self, factory())
    }
    
    @discardableResult
    static func registerUnique<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerUnique(type) { _ in
            factory()
        }
    }
    
    @discardableResult
    static func registerShared<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerShared(type) { _ in
            factory()
        }
    }
    
    @discardableResult
    static func registerWeak<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) -> Registration<T> {
        registerWeak(type) { _ in
            factory()
        }
    }
}
