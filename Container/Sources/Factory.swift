import Foundation

protocol Factory {
    
    func create() -> Any
}

final class PerRequestFactory: Factory {
    let resolver: Resolver
    let factory: (Resolver) -> Any
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        factory(resolver)
    }
}

final class SharedFactory: Factory {
    let resolver: Resolver
    let factory: (Resolver) -> Any
    var instance: Any?
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        if let instance = instance {
            return instance
        }
        let newInstance = factory(resolver)
        instance = newInstance
        return newInstance
    }
}

final class WeakFactory: Factory {
    let resolver: Resolver
    let factory: (Resolver) -> Any
    weak var instance: AnyObject?
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        if let instance = instance {
            return instance
        }
        let newInstance = factory(resolver) as AnyObject
        instance = newInstance
        return newInstance
    }
}
