//
//  MessageCell.swift
//  ChatWithParse
//
//  Created by Anastasia Blodgett on 10/27/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit
import Parse

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    var message: PFObject! {
        didSet {
            let text = message?["text"] as? String ?? ""
            messageLabel.text = text
            let user = message?["user"] as? PFUser
            let userName = user?["username"] as? String
            if userName == nil {
                userLabel.isHidden = true
            }
            else {
                userLabel.text = userName
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
