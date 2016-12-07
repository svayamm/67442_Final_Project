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
        
        /* This method 'listens' for when the user is authenticated,
           taking the user to the main 'agenda' page upon authentication */
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            // If a user object exists
            if user != nil {
                // Create a new instance of the main storyboard.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                // Create an instance of the storyboard's initial view controller.
                let controller = storyboard.instantiateViewController(withIdentifier: "Agenda") as UIViewController
                
                // Display the new view controller.
                weak var weakSelf = self
                weakSelf?.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func setupGoogleButton() {
        // Add Google sign-in button programatically
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 25, y: 300, width: view.frame.width-50, height: 50)
        // magic numbers!
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
