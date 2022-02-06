import Foundation

protocol InstanceFactory: AnyObject {
    typealias Configuration = (Resolver, Any) -> Void
    var postInitialization: Configuration? { get set }
    var postResovle: Configuration? { get set }
    func create() -> Any
}

final class UniqueInstanceFactory: InstanceFactory {
    var postInitialization: Configuration?
    var postResovle: Configuration?
    
    private let resolver: Resolver
    private let factory: (Resolver) -> Any
    
    init(resolver: Resolver, factory: @escaping (Resolver) -> Any) {
        self.resolver = resolver
        self.factory = factory
    }
    
    func create() -> Any {
        let instance = factory(resolver)
        postInitialization?(resolver, instance)
        postResovle?(resolver, instance)
        return instance
    }
}

final class SharedInstanceFactory: InstanceFactory {
    var postInitialization: Configuration?
    var postResovle: Configuration?
    
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
            postResovle?(resolver, instance)
            return instance
        }
        let newInstance = factory(resolver)
        postInitialization?(resolver, newInstance)
        postResovle?(resolver, newInstance)
        instance = newInstance
        return newInstance
    }
}

final class WeakInstanceFactory: InstanceFactory {
    var postInitialization: Configuration?
    var postResovle: Configuration?
    
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
            postResovle?(resolver, instance)
            return instance
        }
        let newInstance = factory(resolver) as AnyObject
        postInitialization?(resolver, newInstance)
        postResovle?(resolver, newInstance)
        instance = newInstance
        return newInstance
    }
}
