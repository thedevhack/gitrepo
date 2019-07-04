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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
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
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
                PresentLoginController()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }else{
            PresentLoginController()
        }
    }
}
