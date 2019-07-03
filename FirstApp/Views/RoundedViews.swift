//
//  RoundedViews.swift
//  FirstApp
//
//  Created by Ansu-Pc on 03/07/19.
//  Copyright © 2019 Ansu-Pc. All rights reserved.
//

import UIKit

class RoundedButtons : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5    }
    
}

class RoundedView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = AppColors.Blue.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}
class RoundedImageView : UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}
