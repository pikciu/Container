//
//  File.swift
//  
//
//  Created by Tomasz Pikć on 11/04/2024.
//

import Foundation

extension Container {
    
    public static func resolve<T>(_ type: T.Type) -> T {
        shared.resolve(type)
    }

    public static func resolve<T>() -> T {
        resolve(T.self)
    }
    
    public static func register(modules: [Module.Type]) {
        shared.register(modules: modules)
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
    
    public static func registerUnique<T>(factory: @escaping (Resolver) -> T) {
        registerUnique(T.self, factory: factory)
    }
    
    public static func registerShared<T>(factory: @escaping (Resolver) -> T) {
        registerShared(T.self, factory: factory)
    }
    
    public static func registerWeak<T>(factory: @escaping (Resolver) -> T) {
        registerWeak(T.self, factory: factory)
    }
    
    public static func registerUnique<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerUnique(type) { _ in
            factory()
        }
    }
    
    public static func registerShared<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerShared(type) { _ in
            factory()
        }
    }
    
    public static func registerWeak<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        registerWeak(type) { _ in
            factory()
        }
    }
    
    public static func registerUnique<T>(_ factory: @autoclosure @escaping () -> T) {
        registerUnique(T.self, factory())
    }
    
    public static func registerShared<T>(_ factory: @autoclosure @escaping () -> T) {
        registerShared(T.self, factory())
    }
    
    public static func registerWeak<T>(_ factory: @autoclosure @escaping () -> T) {
        registerWeak(T.self, factory())
    }
    
    public static func registerUnique<T: Resolvable>(_ resolvable: T.Type) {
        registerUnique { T(with: $0) }
    }
    
    public static func registerShared<T: Resolvable>(_ resolvable: T.Type) {
        registerShared { T(with: $0) }
    }
    
    public static func registerWeak<T: Resolvable>(_ resolvable: T.Type) {
        registerWeak { T(with: $0) }
    }
}
