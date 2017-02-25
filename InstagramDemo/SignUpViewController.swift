//
//  SignUpViewController.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/24/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    var photoTakingHelper: PhotoHelper?
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        signUpButton.layer.cornerRadius = 4
        
        let photoTap = UITapGestureRecognizer()
        photoTap.addTarget(self, action: #selector(SignUpViewController.tappedImage))
        profilePhoto.addGestureRecognizer(photoTap)
        profilePhoto.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedImage(){
        takePhoto()
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)

        
        let newUser = PFUser()
        
        if let name = fullName.text{
            newUser["name"] = name
        }else{
            //alert
        }
        
        if let username = username.text{
            newUser["nickname"] = username
        }else{
            //alert
        }
        
        if let image = profilePhoto.image{
            if let imageData = UIImageJPEGRepresentation(image, 0.8) {
                newUser["profile_photo"] = PFFile(name: "profile.png", data: imageData)
            }
        }else{
            if let imageData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "profiledefault"), 0.8) {
                newUser["profile_photo"] = PFFile(name: "profile.png", data: imageData)
            }
            profilePhoto.image = #imageLiteral(resourceName: "profiledefault")
        }
        
        if let email = emailAddress.text{
            newUser.username = email
        }else{
            //Alert
        }
        
        if let password = password.text{
            newUser.password = password
        }else{
            //Alert
        }
        
        if confirmPassword.text != password.text{
            //alert
        }

        newUser.signUpInBackground(block: { (success: Bool, error: Error?) in
            if error == nil{
                //success
                let instagramVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                    self.present(instagramVC, animated: false, completion: nil)
                    self.activityView.stopAnimating()
            }else{
                print(error!.localizedDescription)
            }
        })
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func takePhoto(){
        photoTakingHelper = PhotoHelper(viewController: self, callback: { (image: UIImage?) in
            self.profilePhoto.image = image
        })
    }
}
