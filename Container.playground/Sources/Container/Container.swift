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
    private var factories: [ObjectIdentifier : InstanceFactory] = [:]
    
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
    
    public func registerUnique<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[ObjectIdentifier(type)] = UniqueInstanceFactory(
            resolver: self,
            factory: factory
        )
    }
    
    public func registerShared<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[ObjectIdentifier(type)] = SharedInstanceFactory(
            resolver: self,
            factory: factory
        )
    }
    
    public func registerWeak<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[ObjectIdentifier(type)] = WeakInstanceFactory(
            resolver: self,
            factory: factory
        )
    }
    
    public func register(modules: [Module.Type]) {
        modules.forEach { module in
            module.register(in: self)
        }
    }
    
    public static func resolve<T>(_ type: T.Type) -> T {
        shared.resolve(type)
    }
    
    public static func registerUnique<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        shared.registerUnique(type, factory: factory)
    }
    
    public static func registerShared<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        shared.registerShared(type, factory: factory)
    }
    
    public static func registerWeak<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) {
        shared.registerWeak(type, factory: factory)
    }
    
    public static func register(modules: [Module.Type]) {
        shared.register(modules: modules)
    }
}
