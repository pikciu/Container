import Foundation

public extension Container {
    
    func registerUnique<T>(factory: @escaping (Resolver) -> T) {
        registerUnique(T.self, factory: factory)
    }
    
    func registerShared<T>(factory: @escaping (Resolver) -> T) {
        registerShared(T.self, factory: factory)
    }
    
    func registerWeak<T>(factory: @escaping (Resolver) -> T) {
        registerWeak(T.self, factory: factory)
    }
    
    func registerUnique<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerUnique(type) { _ in
            factory()
        }
    }
    
    func registerShared<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerShared(type) { _ in
            factory()
        }
    }
    
    func registerWeak<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerWeak(type) { _ in
            factory()
        }
    }
    
    func registerUnique<T>(_ factory: @autoclosure @escaping () -> T) {
        registerUnique(T.self, factory())
    }
    
    func registerShared<T>(_ factory: @autoclosure @escaping () -> T) {
        registerShared(T.self, factory())
    }
    
    func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) {
        registerWeak(T.self, factory())
    }
    
    static func registerUnique<T>(_ factory: @autoclosure @escaping () -> T) {
        registerUnique(T.self, factory())
    }
    
    static func registerShared<T>(_ factory: @autoclosure @escaping () -> T) {
        registerShared(T.self, factory())
    }
    
    static func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) {
        registerWeak(T.self, factory())
    }
    
    static func registerUnique<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerUnique(type) { _ in
            factory()
        }
    }
    
    static func registerShared<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerShared(type) { _ in
            factory()
        }
    }
    
    static func registerWeak<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerWeak(type) { _ in
            factory()
        }
    }
}
