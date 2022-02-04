import Foundation

protocol Factory {
    func create() -> Any
}

final class PerRequestFactory: Factory {
    private let resolver: Resolver
    private let factory: (Resolver) -> Any
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        factory(resolver)
    }
}

final class SharedFactory: Factory {
    private let lock = NSLock()
    private let resolver: Resolver
    private let factory: (Resolver) -> Any
    private var instance: Any?
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        lock.lock()
        defer {
            lock.unlock()
        }
        if let instance = instance {
            return instance
        }
        let newInstance = factory(resolver)
        instance = newInstance
        return newInstance
    }
}

final class WeakFactory: Factory {
    private let lock = NSLock()
    private let resolver: Resolver
    private let factory: (Resolver) -> Any
    private weak var instance: AnyObject?
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        lock.lock()
        defer {
            lock.unlock()
        }
        if let instance = instance {
            return instance
        }
        let newInstance = factory(resolver) as AnyObject
        instance = newInstance
        return newInstance
    }
}
