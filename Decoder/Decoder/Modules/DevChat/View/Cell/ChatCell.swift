//
//  ChatCell.swift
//  Decoder
//
//  Created by LaxmiPrasad Sahu on 06/04/19.
//  Copyright © 2019 C1X. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var recievedMessageLbl: UILabel!
    
    @IBOutlet weak var recievedMessageView: UIView!
    
    @IBOutlet weak var sentMessageLbl: UILabel!
    
    @IBOutlet weak var sentMessageView: UIView!
    @IBOutlet weak var sentImage: UIImageView!
    @IBOutlet weak var recivedImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundCornerWithBorder(uiView: sentImage, borderColor: UIColor.gray, borderWidth: 1)
        roundCornerWithBorder(uiView: recivedImage, borderColor: UIColor.gray, borderWidth: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(chatModel: ChatModelElement?) {
        guard let chatObject = chatModel else { return  }
        
        if chatObject.userName == "Dcoder" {
            
            sentMessageView.isHidden = false
            
            sentMessageLbl.text = chatObject.userName
            
            recievedMessageLbl.text = ""
            
            
            recievedMessageLbl.isHidden = true
            recievedMessageView.isHidden = true
            recivedImage.isHidden = true
            guard let url = URL(string: chatObject.userImageURL ?? "") else {return}
            downloadImage(from: url) { data in
                DispatchQueue.main.async() {
                self.sentImage.image = UIImage(data: data)
                }
            }
            
            
        } else {
            
            sentMessageView.isHidden = true
            sentImage.isHidden = true
            
            sentMessageLbl.text = ""
            
            recievedMessageLbl.text = chatObject.userName
            
            recievedMessageLbl.isHidden = false
            guard let url = URL(string: chatObject.userImageURL ?? "") else {return}
            downloadImage(from: url) { data in
                DispatchQueue.main.async() {
                self.recivedImage.image = UIImage(data: data)
                }
            }
        }
    }
    func downloadImage(from url: URL, compile: @escaping (_ data: Data ) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            compile(data)
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

func roundCornerWithBorder(uiView: UIView, borderColor: UIColor, borderWidth: CGFloat) {
    uiView.layer.borderWidth = borderWidth
    uiView.layer.masksToBounds = false
    uiView.layer.borderColor = borderColor.cgColor
    uiView.layer.cornerRadius = uiView.frame.size.height/2
    uiView.clipsToBounds = true
}
