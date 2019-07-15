//
//  LoginVC.swift
//  FirstApp
//
//  Created by Ansu-Pc on 03/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func forgotPassClicked(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .currentContext
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func loginClicked(_ sender: Any) {
    
        guard let email = emailTxt.text , email.isNotEmpty ,
        let password = passwordTxt.text , password.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please Fill Out All Fields")
            return }
        activityIndicator.startAnimating()
    
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint(error)
                self.activityIndicator.stopAnimating()
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            } else {
                self.activityIndicator.stopAnimating()
                self.dismiss(animated: true, completion: nil)
            }
        }
    
    }
    @IBAction func guestloginClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
