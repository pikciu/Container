import Foundation

extension Container {
    
    public func registerUnique<T>(factory: @escaping (Resolver) -> T) {
        registerUnique(T.self, factory: factory)
    }
    
    public func registerShared<T>(factory: @escaping (Resolver) -> T) {
        registerShared(T.self, factory: factory)
    }
    
    public func registerWeak<T>(factory: @escaping (Resolver) -> T) {
        registerWeak(T.self, factory: factory)
    }
    
    public func registerUnique<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerUnique(type) { _ in
            factory()
        }
    }
    
    public func registerShared<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerShared(type) { _ in
            factory()
        }
    }
    
    public func registerWeak<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerWeak(type) { _ in
            factory()
        }
    }
    
    public func registerUnique<T>(_ factory: @autoclosure @escaping () -> T) {
        registerUnique(T.self, factory())
    }
    
    public func registerShared<T>(_ factory: @autoclosure @escaping () -> T) {
        registerShared(T.self, factory())
    }
    
    public func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) {
        registerWeak(T.self, factory())
    }
    
    public func registerUnique<T: Resolvable>(_ resolvable: T.Type) {
        registerUnique { T(with: $0) }
    }
    
    public func registerShared<T: Resolvable>(_ resolvable: T.Type) {
        registerShared { T(with: $0) }
    }
    
    public func registerWeak<T: Resolvable>(_ resolvable: T.Type) {
        registerWeak { T(with: $0) }
    }
}
