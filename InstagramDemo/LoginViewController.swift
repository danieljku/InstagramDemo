//
//  LoginViewController.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/24/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = view
        }else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(_ sender: Any) {
        guard let email = emailAddress.text else{
            //Alert
            return
        }
        
        guard let password = password.text else{
            //Alert
            return
        }
        
        PFUser.logInWithUsername(inBackground: email, password: password) { (user: PFUser?, error: Error?) in
            if error == nil{
                let instagramVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                
                self.present(instagramVC, animated: true, completion: nil)
            }else{
                print(error!.localizedDescription)
            }

        }
        
    }


}

