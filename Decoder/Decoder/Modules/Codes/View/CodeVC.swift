//
//  CodeVC.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import UIKit

protocol CodeVCDelegate {
    func updateData(object: CodeResponseModelElement)
}
class CodeVC: UIViewController, UITextViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btn_type: UIButton!
    @IBOutlet weak var btn_selected: UIButton!
    @IBOutlet weak var btn_programName: UIButton!
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_vote: UILabel!
    @IBOutlet weak var lbl_Comment: UILabel!
    @IBOutlet weak var lbl_days: UILabel!
    @IBOutlet weak var txt_view: UITextView!
    
    var viewModel: CodeVMDelegate?
    var selectedIndex: Int?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCornerWithBorder(uiView: img_profile, borderColor: UIColor.white, borderWidth: 2)
        self.btn_type.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.btn_programName.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.btn_selected.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.txt_view.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15)
       self.viewModel = DependancyManager.get(CodeVMDelegate.self)
        if self.viewModel?.view == nil {
            self.viewModel?.view = self
        }
        viewModel?.fetchCodeList()
    }
    
    @IBAction func btn_Type(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProgramListVC") as! ProgramListVC
        vc.delegate = self
        vc.type = Type.tag.rawValue
        self.type = Type.tag.rawValue
        vc.codeModel = self.viewModel?.getCodeObjectForSelectedIndex(index: selectedIndex ?? 0)
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_programName(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProgramListVC") as! ProgramListVC
        vc.delegate = self
        vc.type = Type.lng.rawValue
        self.type = Type.lng.rawValue
        vc.codeResponse = self.viewModel?.getCoderesponse()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
    textView.resignFirstResponder()
    return false
    }
    return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
extension CodeVC: CodeVCDelegate {
    func updateData(object: CodeResponseModelElement) {
        self.lbl_title.text = object.title
        self.lbl_name.text = object.userName
        self.lbl_vote.text = String((object.downvotes ?? 0) + (object.upvotes ?? 0))
        self.lbl_Comment.text = String(object.comments ?? 0)
        self.lbl_days.text = object.time
        self.btn_programName.setTitle(object.codeLanguage?.rawValue, for: .normal)
        self.btn_selected.setTitle((object.tags?[selectedIndex ?? 0].rawValue), for: .normal)
        self.txt_view.text = object.code
        guard let url = URL(string: object.userImageURL ?? "") else { return  }
        self.downloadImage(from: url)
        
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.img_profile.image = UIImage(data: data)
            }
        }
    }
}
extension CodeVC: ProgramListVCDelegate {
    func selectedIndex(index: Int) {
         if type == Type.lng.rawValue {
            self.selectedIndex = nil
         } else {
           self.selectedIndex = index
        }
        self.viewModel?.updateData(index: index)
    }
    
}
