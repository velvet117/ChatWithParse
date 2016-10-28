//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Anastasia Blodgett on 10/27/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject]!
    
    @IBAction func onSendClick(_ sender: UIButton) {
        
        let messageObject = PFObject(className: "MessageSF")
        messageObject["text"] = self.messageTextField.text
        messageObject["user"] = PFUser.current()
        
        messageObject.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print(messageObject["text"])
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        cell.message = messages[indexPath.row]
        return cell
    }

    func onTimer() {
        let query = PFQuery(className: "MessageSF")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            
            if error == nil {
                print("Successfully retrieving objects")
                
                if let objects = objects {
                    self.messages = objects
                }
                self.tableView.reloadData()
            } else {
                print("Error: \(error?.localizedDescription)")
            }
            
            
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
