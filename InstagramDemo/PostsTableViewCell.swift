//
//  PostsTableViewCell.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/25/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var caption: UILabel!

    var post: PFObject!{
        didSet{
            if let postPic = post.value(forKey: "post_photo")! as? PFFile {
                postPic.getDataInBackground(block: { (imageData: Data?, error: Error?) in
                    if (error == nil) {
                        let image = UIImage(data: imageData!)
                        self.postImage.image = image
                    }
                })
            }
            let user = post["author"] as! PFObject
            username.text = user["nickname"] as? String
            
            if let profilePic = user.value(forKey: "profile_photo")! as? PFFile {
                profilePic.getDataInBackground(block: { (imageData: Data?, error: Error?) in
                    if (error == nil) {
                        let image = UIImage(data: imageData!)
                        self.profileImage.image = image

                    }
                })
            }
            
            caption.text = post["caption"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
