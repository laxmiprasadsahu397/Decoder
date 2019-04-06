//
//  ChatVM.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation
protocol ChatVMDelegate {
    var view: ChatVCDelegate? {get set}
    func fetchfetchChatList()
    func getChatResponseCount() -> Int
    func loadDataatIndex(index: Int) -> ChatModelElement?
}
class ChatVM: ChatVMDelegate {
    
    var view: ChatVCDelegate?
    var chatWebServiceDelegate: ChatWebserviceDelegate?
    private var chatResponse: ChatModel?
    
    init() {
        self.chatWebServiceDelegate = DependancyManager.get(ChatWebserviceDelegate.self)
    }
    
    func fetchfetchChatList() {
        self.chatWebServiceDelegate?.fetchChatData(completion: { [unowned self] chatModels in
            self.chatResponse = chatModels
            self.view?.reloadData()
        })
    }
    
    func getChatResponseCount() -> Int {
         return self.chatResponse?.count ?? 0
    }
    func loadDataatIndex(index: Int) -> ChatModelElement? {
        return self.chatResponse?[index]
    }
}
