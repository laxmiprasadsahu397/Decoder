//
//  ChatWebservice.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation

protocol ChatWebserviceDelegate {
    func fetchChatData(completion :@escaping (ChatModel) -> ())
}

class ChatWebservice: ChatWebserviceDelegate {
    
    func fetchChatData(completion :@escaping (ChatModel) -> ()) {
        
        
        let urlString = Endpoints.URLList.chat.url
        
        let chatBySourceURL = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: chatBySourceURL) { data, _, _ in
            
            if let data = data {
                
                guard let chatResponseModel = try? JSONDecoder().decode(ChatModel.self, from: data) else {
                    return
                }
                DispatchQueue.main.async {
                    completion(chatResponseModel)
                }
            }
            
            }.resume()
    }
    
}
