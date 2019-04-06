//
//  CodeResponseModel.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//
//
//   let codeResponseModel = try? newJSONDecoder().decode(CodeResponseModel.self, from: jsonData)

import Foundation

typealias CodeResponseModel = [CodeResponseModelElement]

struct CodeResponseModelElement: Codable {
    let userName: String?
    let userImageURL: String?
    let time: String?
    let tags: [CodeLanguage]?
    let title, code: String?
    let codeLanguage: CodeLanguage?
    let upvotes, downvotes, comments: Int?
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case userImageURL = "user_image_url"
        case time, tags, title, code
        case codeLanguage = "code_language"
        case upvotes, downvotes, comments
    }
}

enum CodeLanguage: String, Codable {
    case android = "android"
    case python = "python"
    case python20 = "python2.0"
}
