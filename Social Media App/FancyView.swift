//
//  fancyView.swift
//  Social Media App
//
//  Created by Saska Rauhala on 9.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class FancyView: UIView {


    override func awakeFromNib() {
       
        super.awakeFromNib()
        self.layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        self.layer.shadowOpacity = 0.0
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }
    
}
