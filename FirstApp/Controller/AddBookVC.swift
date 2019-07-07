//
//  AddBookVC.swift
//  FirstApp
//
//  Created by Ansu-Pc on 07/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Firebase

class AddBookVC: UIViewController {
    var refAddBooks: DatabaseReference!
    @IBOutlet weak var booktitleTxt: UITextField!
    @IBOutlet weak var bookauthorTxt: UITextField!
    @IBOutlet weak var bookconditionTxt: UITextField!
    @IBOutlet weak var bookoriginalpriceTxt: UITextField!
    @IBOutlet weak var bookofferpriceTxt: UITextField!
    @IBOutlet weak var bookcategoryTxt: UITextField!
    @IBOutlet weak var bookImageChoose: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refAddBooks = Database.database().reference().child("BooksDetails")
    }
    func addBooksDetails() {
        let key = refAddBooks.childByAutoId().key
        
        let BooksDetails = ["id":key,
                            "BooksTitle":booktitleTxt.text! as String ,
                            "BooksAuthor":bookauthorTxt.text! as String ,
                            "BooksCondition":bookconditionTxt.text! as String ,
                            "BookOriginalPrice":bookoriginalpriceTxt.text! as String ,
                            "BookOfferPrice":bookofferpriceTxt.text! as String ,
                            "BookCategory":bookcategoryTxt.text! as String
                             ]
        refAddBooks.child(key!).setValue(BooksDetails)
    }
    @IBAction func bookdetailsubmitClicked(_ sender: Any)
    {
        addBooksDetails()
    }
    
}
