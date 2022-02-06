import Foundation

public protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T
    static func resolve<T>(_ type: T.Type) -> T
}

public extension Resolver {
    func resolve<T>() -> T {
        resolve(T.self)
    }
    
    static func resolve<T>() -> T {
        resolve(T.self)
    }
}

public final class Container: Resolver {
    private var registrations: [ObjectIdentifier : AnyRegistration] = [:]
    
    private static let shared = Container()
    
    public init() {
        
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(type)
        guard
            let registration = registrations[key],
            let instance = registration.create() as? T
        else {
            fatalError("Instance of type: \(T.self) not found!")
        }
        return instance
    }
    
    @discardableResult
    public func registerUnique<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T> {
        let registration = Registration<T>(factory: UniqueInstanceFactory(
            resolver: self,
            factory: factory
        ))
        registrations[ObjectIdentifier(type)] = registration
        return registration
    }
    
    @discardableResult
    public func registerShared<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T> {
        let registration = Registration<T>(factory: SharedInstanceFactory(
            resolver: self,
            factory: factory
        ))
        registrations[ObjectIdentifier(type)] = registration
        return registration
    }
    
    @discardableResult
    public func registerWeak<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T> {
        let registration = Registration<T>(factory: WeakInstanceFactory(
            resolver: self,
            factory: factory
        ))
        registrations[ObjectIdentifier(type)] = registration
        return registration
    }
    
    public func register(modules: [Module.Type]) {
        modules.forEach { module in
            module.register(in: self)
        }
    }
    
    public static func resolve<T>(_ type: T.Type) -> T {
        shared.resolve(type)
    }
    
    @discardableResult
    public static func registerUnique<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T> {
        shared.registerUnique(type, factory: factory)
    }
    
    @discardableResult
    public static func registerShared<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T> {
        shared.registerShared(type, factory: factory)
    }
    
    @discardableResult
    public static func registerWeak<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T> {
        shared.registerWeak(type, factory: factory)
    }
    
    public static func register(modules: [Module.Type]) {
        shared.register(modules: modules)
    }
}
