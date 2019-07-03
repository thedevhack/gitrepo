//
//  ViewController.swift
//  FirstApp
//
//  Created by Ansu-Pc on 29/06/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "LoginStoryBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        present(controller, animated: true, completion: nil)    }

}

