import Foundation

@propertyWrapper
public struct Inject<T> {
    
    private let resolver: Resolver
    
    public init(resolver: Resolver = Container.shared) {
        self.resolver = resolver
    }

    public var wrappedValue: T {
        resolver.resolve(T.self)
    }
}
