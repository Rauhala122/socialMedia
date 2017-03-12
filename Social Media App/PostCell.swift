//
//  PostCell.swift
//  Social Media App
//
//  Created by Saska Rauhala on 11.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: Circleimage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    func updateUi(post: Post, img: UIImage? = nil) {
        caption.text = post.caption
        likesLbl.text = "\(post.likes)"
        if img != nil {
            self.postImage.image = img
        } else {
             let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("SASKA: Unable to download image from firebase storage")
                    } else {
                        print("SASKA: Image Successfully downloaded from firebase storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.postImage.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                })
            }
        }
    
}
