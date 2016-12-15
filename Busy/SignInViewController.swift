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
                // Display the 'Agenda' view controller.
                weak var weakSelf = self // required to fix 'implicit use of self in closure' error
                
                weakSelf?.performSegue(withIdentifier: "LoginToMain", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToMain"
        {
            if let destinationVC = segue.destination as?  ViewController {
                let firebaseUser = FIRAuth.auth()?.currentUser
                let userObj = User(firebaseUID: (firebaseUser?.uid)!, displayName: (firebaseUser?.displayName)!, email: (firebaseUser?.email)!)
                // create a new user object (different variable name to differentiate from 'user' used above
                // This user object will be used internally, passed to the Agenda view controller
                destinationVC.userObject = userObj
                
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
