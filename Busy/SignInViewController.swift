//
//  SignInViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 27/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupGoogleButton()
        
    }
    
    func setupGoogleButton() {
        // Add Google sign-in button programatically
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 25, y: 300, width: view.frame.width-50, height: 50 ) // magic numbers!
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
