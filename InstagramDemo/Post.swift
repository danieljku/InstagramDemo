//
//  Post.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/25/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {

    func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["post_photo"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImageJPEGRepresentation(image, 0.8) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
