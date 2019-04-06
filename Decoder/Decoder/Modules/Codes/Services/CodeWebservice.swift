//
//  CodeWebservice.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import Foundation

protocol CodeWebserviceDelegate {
   func fetchCodeData(completion :@escaping (CodeResponseModel) -> ())
}

class CodeWebservice: CodeWebserviceDelegate {
    
    func fetchCodeData(completion :@escaping (CodeResponseModel) -> ()) {
        
        
        let urlString = Endpoints.URLList.code.url
        
        let codeBySourceURL = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: codeBySourceURL) { data, _, _ in
            
            if let data = data {
                
                print(String(data: data, encoding: String.Encoding.utf8))
                guard let codeResponseModel = try? JSONDecoder().decode(CodeResponseModel.self, from: data) else {
                    return
                }
                DispatchQueue.main.async {
                    completion(codeResponseModel)
                }
            }
            
            }.resume()
    }
        
}
