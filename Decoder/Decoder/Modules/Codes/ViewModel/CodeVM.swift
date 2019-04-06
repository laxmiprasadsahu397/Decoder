//
//  CodeVM.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import UIKit

protocol CodeVMDelegate {
    var view: CodeVCDelegate? {get set}
    func fetchCodeList()
    func updateData(index: Int)
    func getCoderesponse() -> CodeResponseModel?
    func getCodeObjectForSelectedIndex(index: Int) -> CodeResponseModelElement?
}

class CodeVM: CodeVMDelegate {
    
    var view: CodeVCDelegate?
    var codeWebServiceDelegate: CodeWebserviceDelegate?
    private var codeResponse: CodeResponseModel?
    
    init() {
       self.codeWebServiceDelegate = DependancyManager.get(CodeWebserviceDelegate.self)
    }
     func fetchCodeList() {
        self.codeWebServiceDelegate?.fetchCodeData(completion: { [unowned self] codeModels in
            self.codeResponse = codeModels
           self.updateData(index: 0)
        })
    }
    func updateData(index: Int) {
      guard let object = self.codeResponse?[index] else { return  }
        self.view?.updateData(object: object)
    }
    func getCoderesponse() -> CodeResponseModel? {
      return self.codeResponse
    }
    func getCodeObjectForSelectedIndex(index: Int) -> CodeResponseModelElement? {
        return self.codeResponse?[index]
    }
    
}
