//
//  ChatModel.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation

typealias ChatModel = [ChatModelElement]

struct ChatModelElement: Codable {
    let userName: String?
    let userImageURL: String?
    let isSentByMe: Bool?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case userImageURL = "user_image_url"
        case isSentByMe = "is_sent_by_me"
        case text
    }
}
