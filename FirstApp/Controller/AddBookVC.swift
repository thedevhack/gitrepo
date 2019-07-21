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
    
    
    @IBOutlet weak var activityIndic: UIActivityIndicatorView!
    @IBOutlet weak var booktitle: UITextField!
    @IBOutlet weak var bookauthor: UITextField!
    @IBOutlet weak var bookcondition: UITextField!
    @IBOutlet weak var bookcategory: UITextField!
    @IBOutlet weak var bookoriginalprice: UITextField!
    @IBOutlet weak var bookImageChoose: UIImageView!
    @IBOutlet weak var boodesc: UITextField!
    @IBOutlet weak var bookgenre: UITextField!
    @IBOutlet weak var bookofferprice: UITextField!
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
                    
                    let BooksDetails = ["BooksTitle":self.booktitle.text! as String ,
                                    "BooksAuthor":self.bookauthor.text! as String ,
                                    "BooksCondition":self.bookcondition.text! as String ,
                                    "BookOriginalPrice":self.bookoriginalprice.text! as String ,
                                    "BookOfferPrice":self.bookofferprice.text! as String ,
                                    "BookCategory":self.bookcategory.text! as String ,
                                    "BookGenre":self.bookgenre.text! as String ,
                                    "BookDesc":self.boodesc.text! as String ,
                                    "BookImageUrl":downloadURLString
                    ]
                    self.AddBookIntoDatabase(BooksDetails: BooksDetails as [String : AnyObject])
                
    
                }
            }
        }
        
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        self.navigationController?.pushViewController(vc2!, animated: true)
    }
    func AddBookIntoDatabase(BooksDetails:[String:AnyObject]) {
    let key = refAddBooks.childByAutoId().key
    refAddBooks = Database.database().reference().child("BooksDetails")
        refAddBooks.child(key!).setValue(BooksDetails)
}
    
    @IBAction func submitbookdetails(_ sender: Any) {
        addBooksDetails()
    }
    
}
