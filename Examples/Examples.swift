import Foundation

public final class Examples {
    
    public init() {
        
    }
    
    public func register() {
        Container.register(modules: [SampleModule.self])
    }
    
    public func registerDependencyCycle() {
        Container.registerWeak(A.self) { resolver in
            A(b: resolver.resolve(), c: resolver.resolve())
        }
        
        Container.registerWeak(B())
        Container.registerWeak(C())
    }
    
    public func resolve() {
        let s1 = Container.resolve(Service1.self)
        let s2 = Container.resolve(Service2.self)
        let s3 = Container.resolve(Service1Impl.self)
        let s4 = Container.resolve(Service1.self)
        let s5 = Container.resolve(Service2.self)
        let s6 = Container.resolve(Service1Impl.self)
        print(s1)
        print(s2)
        print(s3)
        print(s4)
        print(s5)
        print(s6)

        let testService = Container.resolve(TestService.self)
        print(testService)
    }
    
    public func resolveSharedThreadSafe() {
        DispatchQueue(label: "queue 1").async {
            print(Container.resolve(SharedTest.self))
        }

        DispatchQueue(label: "queue 2").async {
            print(Container.resolve(SharedTest.self))
        }

        DispatchQueue(label: "queue 3").async {
            print(Container.resolve(SharedTest.self))
        }

        DispatchQueue(label: "queue 4").async {
            print(Container.resolve(SharedTest.self))
        }
    }
    
    public func resolveDependencyCycle() {
        let a = Container.resolve(A.self)
        let b = Container.resolve(B.self)
        b.a = a
        print(a.b === b)
        
        let c = Container.resolve(C.self)
        print(a.c === c)
    }
}
