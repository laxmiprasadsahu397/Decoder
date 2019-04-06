//
//  DependancyRegistrar.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation

open class DependancyRegistrar {
    
        open class func registerDependancies() {
            registerViewModels()
            registerServices()
        }
        
        fileprivate class func registerViewModels() {
            DependancyManager.register(CodeVMDelegate.self) { CodeVM() }
            DependancyManager.register(ChatVMDelegate.self) { ChatVM() }
            
        }
        
        fileprivate class func registerServices() {
            DependancyManager.register(CodeWebserviceDelegate.self){CodeWebservice()}
            DependancyManager.register(ChatWebserviceDelegate.self){ChatWebservice()}
            
        }
    
}
