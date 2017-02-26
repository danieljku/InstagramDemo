//
//  CaptionViewController.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/25/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptionViewController: UIViewController {
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var caption: UITextView!

    let post = Post()
    var imageToPost: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        self.caption.delegate = self

        if let image = imageToPost{
            imagePost.image = image
        }
        
        caption.text = "Add a caption!"
        caption.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFinish(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)

        if let caption = caption.text{
            if let image = imageToPost{
                self.post.postUserImage(image: image, withCaption: caption, withCompletion: { (success: Bool, error: Error?) in
                    if success{
                        self.dismiss(animated: true, completion: {
                            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                            self.present(homeVC, animated: false, completion: nil)
                            MBProgressHUD.hide(for: self.view, animated: true)
                        })
                    }else{
                        print(error!.localizedDescription)
                    }
                })
            }
        }

    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CaptionViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        caption.text = ""
        caption.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if caption.text == nil{
            caption.text = "Add a caption!"
            caption.textColor = UIColor.lightGray
        }
    }
}
