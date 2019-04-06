//
//  Constants.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation

let baseUrl = "http://dcoder.tech/test_json/"
enum Type : String {
    case tag = "Tag"
    case lng = "Language"
}
protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum URLList: Endpoint {
        
        case code
        case chat
        
        public var path: String {
            switch self {
            case .code: return "codes.json"
            case .chat: return "chat.json"
            }
        }
        
        public var url: String {
            switch self {
            case .code:
                print("signIn: \(baseUrl)\(path)")
                return "\(baseUrl)\(path)"
            case .chat:
                print("signUp: \(baseUrl)\(path)")
                return "\(baseUrl)\(path)"
            }
        }
    }
}


