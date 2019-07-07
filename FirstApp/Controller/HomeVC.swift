//
//  ViewController.swift
//  FirstApp
//
//  Created by Ansu-Pc on 29/06/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    @IBOutlet weak var LogInOutButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    
                    debugPrint(error)
                    Auth.auth().handleFireAuthError(error: error, vc: self)}
            }
        }
    }
    //this will change the button title according to who is logged in if it's a annonymous or a verified user
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser , !user.isAnonymous{
            LogInOutButton.title = "Logout"
        }else{
            LogInOutButton.title = "Login"
        }
    
    }

    fileprivate func PresentLoginController() {
        let storyboard = UIStoryboard(name: StoryBoard.LoginStoryBoard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryBoardID.LoginStoryBoardId)
        present(controller, animated: true, completion: nil)
}

    @IBAction func LogInOutClicked(_ sender: Any) {
        //it will first check if a anonymous user is logged in or a verified user is logged in if verified user is logged in it will change the login/logot button to logout and present a login screen again to login again and if a anonymous user is logged in this button will redirect them directly to login screen and not logut the anonymous account
        guard let authUser = Auth.auth().currentUser else {
            return
        }
        if authUser.isAnonymous {
            PresentLoginController()
        }else{
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        debugPrint(error)
                        Auth.auth().handleFireAuthError(error: error, vc: self)                    }
                self.PresentLoginController()
                }
            }catch{
                debugPrint(error)
            }
        }
        /*if let _ = Auth.auth().currentUser {
            do {
                //try Auth.auth().signOut()
                PresentLoginController()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }else{
            PresentLoginController()
        }*/
    }
}
