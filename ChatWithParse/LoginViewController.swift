//
//  LoginViewController.swift
//  ChatWithParse
//
//  Created by Anastasia Blodgett on 10/27/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // PFUser.logOutInBackground()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(_ sender: UIButton) {
        let currentUser = PFUser.current()
        
        if currentUser != nil {
            // Do stuff
            print("You're now logged in")
            self.performSegue(withIdentifier: "showChatSegue", sender: nil)
            
        } else {
            // Show the signup screen
            print("You need to sign up")
            signup()
        }
        
        
        
    }
    
    @IBAction func onSignup(_ sender: UIButton) {
        signup()
    }
    
    private func signup() {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            
            if succeeded {
                print("Sign up succeeded")
                self.performSegue(withIdentifier: "showChatSegue", sender: nil)
            }
            
            if let error = error {
                let errorString = error.localizedDescription
                
                let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }
    
    

}

