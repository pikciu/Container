import Foundation

public extension Container {
    
    func register<T>(factory: @escaping (Resolver) -> T) {
        register(T.self, factory: factory)
    }
    
    func registerShared<T>(factory: @escaping (Resolver) -> T) {
        registerShared(T.self, factory: factory)
    }
    
    func registerWeak<T>(factory: @escaping (Resolver) -> T) {
        registerWeak(T.self, factory: factory)
    }
    
    func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        register(type) { _ in
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
    
    func register<T>(_ factory: @autoclosure @escaping () -> T) {
        register(T.self, factory())
    }
    
    func registerShared<T>(_ factory: @autoclosure @escaping () -> T) {
        registerShared(T.self, factory())
    }
    
    func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) {
        registerWeak(T.self, factory())
    }
    
    static func register<T>(_ factory: @autoclosure @escaping () -> T) {
        register(T.self, factory())
    }
    
    static func registerShared<T>(_ factory: @autoclosure @escaping () -> T) {
        registerShared(T.self, factory())
    }
    
    static func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) {
        registerWeak(T.self, factory())
    }
    
    static func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        register(type) { _ in
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
