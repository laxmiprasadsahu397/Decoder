//
//  ProgramListVC.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import UIKit

protocol ProgramListVCDelegate {
    func selectedIndex(index: Int)
}

class ProgramListVC: UIViewController {

    var codeResponse: CodeResponseModel?
    var codeModel : CodeResponseModelElement?
    var type: String?
    var delegate: ProgramListVCDelegate?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension ProgramListVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard type == Type.lng.rawValue else {
            return codeModel?.tags?.count ?? 0
        }
        return codeResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if type == Type.lng.rawValue {
        tableViewCell?.textLabel?.text = codeResponse?[indexPath.row].codeLanguage?.rawValue
        } else {
        tableViewCell?.textLabel?.text = codeModel?.tags?[indexPath.row].rawValue
        }
        
        return tableViewCell!
    }
    
}
extension ProgramListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.selectedIndex(index: indexPath.row)
    }
}


