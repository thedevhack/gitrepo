//
//  RegisterVC.swift
//  FirstApp
//
//  Created by Ansu-Pc on 03/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var usernametxt: UITextField!
    
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var passwordtxt: UITextField!
    
    @IBOutlet weak var confirmpasswordtxt: UITextField!
    
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var passCheckImg: UIImageView!
    
    @IBOutlet weak var confirmpassCheckImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for everytime checking if the password textfield gets changed then match the password for them to be same
        passwordtxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmpasswordtxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let passTxt=passwordtxt.text else { return }
        
        
        
        if textField == confirmpasswordtxt {
            passCheckImg.isHidden = false
            confirmpassCheckImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmpassCheckImg.isHidden = true
                confirmpasswordtxt.text = ""
                
            }
        }
        
        if passwordtxt.text == confirmpasswordtxt.text {
            passCheckImg.image = UIImage(named: AppImages.GreenCheck)
            confirmpassCheckImg.image = UIImage(named: AppImages.GreenCheck)
        } else{
            passCheckImg.image = UIImage(named: AppImages.RedCheck)
            confirmpassCheckImg.image = UIImage(named: AppImages.RedCheck)        }
        
    }
    

    @IBAction func RegisterClicked(_ sender: Any) {
        guard let username = usernametxt.text , username.isNotEmpty ,
              let email = emailtxt.text , email.isNotEmpty ,
            let password = passwordtxt.text , password.isNotEmpty else {return}
        activityindicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                debugPrint(error)
            }
            print("Successfully Registered User")
            self.activityindicator.stopAnimating()
        }
        
        
    }
    
}
