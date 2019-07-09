//
//  AddBookVC.swift
//  FirstApp
//
//  Created by Ansu-Pc on 07/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Firebase

class AddBookVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
        bookImageChoose.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandleSelectProfileImageView)))
        bookImageChoose.isUserInteractionEnabled = true
        
        }
    //code for launching image picker
    @objc func HandleSelectProfileImageView() {
    let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
}
    //code for selecting image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.bookImageChoose.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.bookImageChoose.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Canceled Picker")
        dismiss(animated: true, completion: nil)
    }
    func addBooksDetails() {
        let key = refAddBooks.childByAutoId().key
        let bookimagename = NSUUID().uuidString
        let addImage = Storage.storage().reference().child("BookImagesPics").child("\(bookimagename).png")
        if let uploadData = bookImageChoose.image?.pngData() {
            addImage.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                addImage.downloadURL { (url, error) in
                    if error != nil{
                        print(error!)
                    }
                guard let downloadURL = url else {return}
                let downloadURLString = downloadURL.absoluteString
                let BooksDetails = ["id":key,
                                    "BooksTitle":self.booktitleTxt.text! as String ,
                                    "BooksAuthor":self.bookauthorTxt.text! as String ,
                                    "BooksCondition":self.bookconditionTxt.text! as String ,
                                    "BookOriginalPrice":self.bookoriginalpriceTxt.text! as String ,
                                    "BookOfferPrice":self.bookofferpriceTxt.text! as String ,
                                    "BookCategory":self.bookcategoryTxt.text! as String ,
                                    "BookImageUrl":downloadURLString
                    ]
                    self.AddBookIntoDatabase(BooksDetails: BooksDetails as [String : AnyObject])
    
                }
            }
        }
    }
    func AddBookIntoDatabase(BooksDetails:[String:AnyObject]) {
    let key = refAddBooks.childByAutoId().key
    refAddBooks = Database.database().reference().child("BooksDetails")
        refAddBooks.child(key!).setValue(BooksDetails)
}
    
    @IBAction func submitBooksDetails(_ sender: UIButton) {
        addBooksDetails()
    }
}
