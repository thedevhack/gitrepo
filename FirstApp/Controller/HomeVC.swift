//
//  ViewController.swift
//  FirstApp
//
//  Created by Ansu-Pc on 29/06/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class HomeVC: UIViewController,UISearchControllerDelegate {
    @IBOutlet weak var LogInOutButton: UIBarButtonItem!
    @IBOutlet weak var tabeView: UITableView!
    @IBOutlet weak var addproducbtn: UIBarButtonItem!
    var ref : DatabaseReference!
    var arrData = [AddBooksModel]()
    let searchcontroller = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.getallFirDara()
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error)
                    Auth.auth().handleFireAuthError(error: error, vc: self)}
            }
        }
        searchBarSetup()
        
    }
    private func searchBarSetup() {
        searchcontroller.searchResultsUpdater = self
        searchcontroller.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchcontroller
        } else {
            // Fallback on earlier versions
        }
        
    }
    //this will change the button title according to who is logged in if it's a annonymous or a verified user
    override func viewDidAppear(_ animated: Bool) {
        self.tabeView.reloadData()
        if let user = Auth.auth().currentUser , !user.isAnonymous{
            LogInOutButton.title = "Logout"
        }else{
            LogInOutButton.title = "Login"
        }
        self.getallFirDara()
    }
    func getallFirDara() {
        self.ref.child("BooksDetails").queryOrderedByKey().observe(.value) { (snapshot) in
            self.arrData.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let mainDict = snap.value as? [String:AnyObject] {
                        let booktitle = mainDict["BooksTitle"] as? String
                        let bookoriginalprice = mainDict["BookOriginalPrice"] as? String
                        let bookcategory = mainDict["BookCategory"] as? String
                        let bookofferprice = mainDict["BookOfferPrice"] as? String
                        let bookauthor = mainDict["BooksAuthor"] as? String
                        let bookcondition = mainDict["BooksCondition"] as? String
                        let bookimageURL = mainDict["BookImageUrl"] as? String ?? ""
                        let bookgenre = mainDict["BookGenre"] as? String ?? ""
                        let bookdesc = mainDict["BookDesc"] as? String ?? ""
                        self.arrData.append(AddBooksModel(booktitle: booktitle!, bookoriginalprice: bookoriginalprice!, bookofferprice: bookofferprice!, bookauthor: bookauthor!, bookcondition: bookcondition!, bookcategory: bookcategory!, bookimageURL: bookimageURL, bookgenre: bookgenre, bookdesc: bookdesc))
                        self.tabeView.reloadData()
                    }
                }
            }
        }
    }
    fileprivate func PresentLoginController() {
        let storyboard = UIStoryboard(name: StoryBoard.LoginStoryBoard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryBoardID.LoginStoryBoardId)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func addproductbtnclick(_ sender: UIBarButtonItem) {
        if let user = Auth.auth().currentUser , !user.isAnonymous {
            let vc1 = storyboard?.instantiateViewController(withIdentifier: "AddBookVC") as? AddBookVC
            self.navigationController?.pushViewController(vc1!, animated: true)
        }else{
            simpleAlert(title: "Error", msg: "Please Sign in Before")
        }    }
    
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
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                    }
                    self.PresentLoginController()
                }
            }catch{
                debugPrint(error)
            }
        }
    }
    
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.BookShow = arrData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = Auth.auth().currentUser , !user.isAnonymous {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BookDetailsViewController") as? BookDetailsViewController
            let url = URL(string: (arrData[indexPath.row].bookimageURL)!)
            if let url = url {
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageUrl) in
                    vc?.bookimgs = image!
                }
            }
            vc?.booktitles = arrData[indexPath.row].booktitle!
            vc?.bookauthors = arrData[indexPath.row].bookauthor!
            vc?.bookconditions = arrData[indexPath.row].bookcondition!
            vc?.bookoriginalprices = arrData[indexPath.row].bookoriginalprice!
            vc?.bookofferprices = arrData[indexPath.row].bookofferprice!
            vc?.bookcategorys = arrData[indexPath.row].bookcategory!
            vc?.bookgenres = arrData[indexPath.row].bookgenre!
            vc?.bookdescs = arrData[indexPath.row].bookdesc!
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            simpleAlert(title: "Error", msg: "Please Sign in Before")
        }
        
    }
}
extension HomeVC:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //later
        guard let searchText = searchcontroller.searchBar.text else {return}
        if searchText == "" {
            getallFirDara()
        }else{
            self.tabeView.reloadData()
            arrData = arrData.filter{
                ($0.booktitle?.contains(searchText))!
            }
        }
        self.tabeView.reloadData()
    }

}
