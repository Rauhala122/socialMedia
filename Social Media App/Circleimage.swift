//
//  Circleimage.swift
//  Social Media App
//
//  Created by Saska Rauhala on 11.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class Circleimage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.width / 2
        
    }

}
