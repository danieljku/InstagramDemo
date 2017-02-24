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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
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
        
        if let name = fullName.text{
            newUser["name"] = name
        }else{
            //alert
        }

        newUser.signUpInBackground(block: { (success: Bool, error: Error?) in
            if error == nil{
                //success
                let instagramVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                self.present(instagramVC, animated: true, completion: nil)
            }else{
                print(error!.localizedDescription)
            }
        })
    }


}
