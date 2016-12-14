//
//  ViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 13/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var userObject: User?
    // this is the user object that will be used throughout the application henceforth
    let rootRef = FIRDatabase.database().reference()
    
    @IBOutlet var test: UIButton!
    @IBOutlet var agendaTableView: UITableView!
    @IBOutlet var timeframeSegment: UISegmentedControl!
    @IBOutlet var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let usersRef = rootRef.child("users")
        // creating child node for 'users' directory in database
        
        guard let userFUID = userObject?.firebaseUID else {print("userObject not set1"); return}
        let idRef = usersRef.child(userFUID)
        // create new node on 'users' directory, with user's FirebaseUID string as key
        guard let userUUID = userObject?.id.uuidString else {print("userObject not set2"); return}
        guard let userName = userObject?.displayName else {print("userObject not set3"); return}
        guard let userEmail = userObject?.email else {print("userObject not set4"); return}
        guard let userProjects = userObject?.projects else {print("userObject not set5"); return}
        let userDict = ["id":userUUID,"firebaseUID": userFUID, "displayName": userName, "email": userEmail, "projects": userProjects ] as [String : Any]
        // UUID converted to string as database cannot store type UUID
        // dictionary of user info created, to be passed into database
        // This is only done once, so the userObject can be discarded.
        idRef.updateChildValues(userDict, withCompletionBlock: {
            (err, ref) in
            
            if err != nil {
                print(err ?? "Error could not be cast as string")
                return}
            
            print("Successfully saved user in FIR Database")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segmented Control
    
    // for the segmented control on top
    @IBAction func indexChanged(sender:UISegmentedControl)
    {
        switch timeframeSegment.selectedSegmentIndex
        {
        case 0:
            print("Today selected");
        case 1:
            print("This Week selected");
        case 2:
            print("All Items selected");
        default:
            break;
        }
    }
    
}

