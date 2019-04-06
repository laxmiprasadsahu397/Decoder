//
//  DependancyManager.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation

open class DependancyManager {
    
    fileprivate static var registry = [String:Any]()
    fileprivate init(){}
    
    static func register<T>(_ key:T.Type, factory: @escaping () -> T) {
        registry["\(T.self)"] = factory
    }
    
    static func get<T>(_:T.Type) -> T? {
        let factory = registry["\(T.self)"] as? () -> T
        return factory.map { $0() }
    }
}
