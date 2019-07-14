//
//  AddBooksModel.swift
//  FirstApp
//
//  Created by Ansu-Pc on 10/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import Foundation
import UIKit


class AddBooksModel {
    var booktitle:String?
    var bookoriginalprice:String?
    var bookofferprice:String?
    var bookcategory:String?
    var bookimageURL:String?
    var bookauthor:String?
    var bookcondition:String?
    
    
    init(booktitle:String, bookoriginalprice:String,bookofferprice:String,bookauthor:String,bookcondition:String, bookcategory:String,bookimageURL:String) {
        self.booktitle = booktitle
        self.bookoriginalprice = bookoriginalprice
        self.bookcategory = bookcategory
        self.bookimageURL = bookimageURL
        self.bookofferprice = bookofferprice
        self.bookauthor = bookauthor
        self.bookcondition = bookcondition

    }
}
