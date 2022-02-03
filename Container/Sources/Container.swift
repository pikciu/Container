import Foundation

public protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T
}

public extension Resolver {
    func resolve<T>() -> T {
        resolve(T.self)
    }
}

public final class Container: Resolver {
    private var factories: [ObjectIdentifier : Factory] = [:]
    
    private static let shared = Container()
    
    public init() {
        
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(type)
        guard
            let factory = factories[key],
            let instance = factory.create() as? T
        else {
            fatalError("Instance of type: \(T.self) not found!")
        }
        return instance
    }
    
    public func register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[ObjectIdentifier(type)] = PerRequestFactory(
            resolver: self,
            factory: factory
        )
    }
    
    public func registerShared<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[ObjectIdentifier(type)] = SharedFactory(
            resolver: self,
            factory: factory
        )
    }
    
    public func registerWeak<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[ObjectIdentifier(type)] = WeakFactory(
            resolver: self,
            factory: factory
        )
    }
    
    public func register(modules: Module.Type...) {
        register(modules: modules)
    }
    
    public static func resolve<T>(_ type: T.Type) -> T {
        shared.resolve(type)
    }
    
    public static func register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        shared.register(type, factory: factory)
    }
    
    public static func registerShared<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        shared.registerShared(type, factory: factory)
    }
    
    public static func registerWeak<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        shared.registerWeak(type, factory: factory)
    }
    
    public static func register(modules: Module.Type...) {
        shared.register(modules: modules)
    }
    
    private func register(modules: [Module.Type]) {
        modules.forEach { module in
            module.register(in: self)
        }
    }
}
