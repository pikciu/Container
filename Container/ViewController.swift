//
//  ViewController.swift
//  Container
//
//  Created by Tomasz Pikć on 02/02/2022.
//

import UIKit

func log(function: String = #function, _ message: @autoclosure () -> Any) {
    print("\(function): \(message())")
}

class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        Container.register(modules: [SampleModule.self])
        
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


}

protocol Service1 {
    
}

protocol Service2 {
    
}

final class Service1Impl: Service1, Service2, CustomDebugStringConvertible {
    var debugDescription: String {
        "Service1Impl: \(type) ID: \(id)"
    }
    
    static var count = 1
    
    let type: String
    let id: Int
    
    init(type: String) {
        self.type = type
        id = Service1Impl.count
        Service1Impl.count += 1
        log(self)
    }
    
    deinit {
        log(self)
    }
}

final class TestService: CustomDebugStringConvertible {
    
    var debugDescription: String {
        "TestService: \n\t\(service1)\n\t\(service2)\n\t\(serviceImpl)"
    }
    
    let service1: Service1
    let service2: Service2
    let serviceImpl: Service1Impl
    
    init(service1: Service1, service2: Service2, serviceImpl: Service1Impl) {
        self.service1 = service1
        self.service2 = service2
        self.serviceImpl = serviceImpl
    }
    
    deinit {
        log(self)
    }
}

struct SampleModule: Module {
    
    static func register(in container: Container) {
        container.registerWeak(Service1.self, Service1Impl(type: "weak"))
        container.registerShared(Service2.self, Service1Impl(type: "shared"))
        container.registerUnique(Service1Impl(type: "unique"))
        
        container.registerShared(SharedTest())
        
        container.registerUnique { resolver in
            TestService(
                service1: resolver.resolve(),
                service2: resolver.resolve(),
                serviceImpl: resolver.resolve()
            )
        }
    }
}

final class SharedTest {
    
    init() {
        log(self)
    }
    
    deinit {
        log(self)
    }
}
