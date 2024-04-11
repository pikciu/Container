import Foundation

public final class Container: Resolver {
    private var factories: [ObjectIdentifier : InstanceFactory] = [:]
    
    public static let shared = Container()
    
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
    
    public func register(modules: [Module.Type]) {
        modules.forEach { module in
            module.register(in: self)
        }
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
}
