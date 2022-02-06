import Foundation

protocol AnyRegistration {
    
    func create() -> Any
}

public final class Registration<T>: AnyRegistration {
    public typealias Configuration = (Resolver, T) -> Void
    private let factory: InstanceFactory
    
    init(factory: InstanceFactory) {
        self.factory = factory
    }
    
    func create() -> Any {
        factory.create()
    }
    
    @discardableResult
    public func onInitialization(configure: @escaping Configuration) -> Self {
        factory.postInitialization = { (resolver, object) in
            guard let object = object as? T else {
                fatalError()
            }
            configure(resolver, object)
        }
        return self
    }
    
    @discardableResult
    public func onResolve(configure: @escaping Configuration) -> Self {
        factory.postResovle = { (resolver, object) in
            guard let object = object as? T else {
                fatalError()
            }
            configure(resolver, object)
        }
        return self
    }
}
