//
//  TableViewCell.swift
//  FirstApp
//
//  Created by Ansu-Pc on 11/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var lblBookCategory: UILabel!
    @IBOutlet weak var lblBookOfferPrice: UILabel!
    var BookShow:AddBooksModel?{
        didSet {
            lblBookTitle.text = "Name:\(BookShow?.booktitle ?? "")"
            lblBookCategory.text = "Author:\(BookShow?.bookauthor ?? "")"
            lblBookOfferPrice.text = "Rs:\(BookShow?.bookofferprice ?? "")"
            let url = URL(string: (BookShow?.bookimageURL)!)
            if let url = url {
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageUrl) in
                    self.imgBook.image = image
                    self.imgBook.kf.indicatorType = .activity
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
