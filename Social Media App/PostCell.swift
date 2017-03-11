//
//  PostCell.swift
//  Social Media App
//
//  Created by Saska Rauhala on 11.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: Circleimage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    
    
}
