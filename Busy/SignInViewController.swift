//
//  SignInViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 27/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncommented to automatically (silently) sign in the user.
        /* Note: When users silently sign in, the Sign-In SDK automatically acquires 
           access tokens and automatically refreshes them when necessary */
        GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
    }
    
    /* If you want to customize the button, do the following:
     In your view controller, declare the sign-in button as a property.
     @IBOutlet weak var signInButton: GIDSignInButton!
     Connect the button to the signInButton property you just declared.
     Customize the button by setting the properties of the GIDSignInButton object. */
    
    /* add sign out method to view w/ sign out button
     @IBAction func didTapSignOut(sender: AnyObject) {
     GIDSignIn.sharedInstance().signOut()
     }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
