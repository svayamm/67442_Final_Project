//
//  UserProfileViewController.swift
//  Busy
//
//  Created by j w on 12/7/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var TaskCountLabel: UILabel!
    @IBOutlet weak var ProjCountLabel: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var TaskCount: UILabel!
    @IBOutlet weak var ProjCount: UILabel!
    
    //let projectsRef = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let firebaseUser = FIRAuth.auth()?.currentUser
        Name.text = firebaseUser?.displayName
        Email.text = firebaseUser?.email
        //let userObj = User(firebaseUID: (firebaseUser?.uid)!, displayName: (firebaseUser?.displayName)!, email: (firebaseUser?.email)!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segmented Control
    
    //for the segmented control on top
    //    @IBAction func indexChanged(sender:UISegmentedControl)
    //    {
    //        switch segmentedControl.selectedSegmentIndex
    //        {
    //        case 0:
    //            print("Today selected");
    //        case 1:
    //            print("This Week selected");
    //        case 2:
    //            print("All Items selected");
    //        default:
    //            break;
    //        }
    //    }
    
    // MARK: - Agenda Page Segues
    //For the bottom toolbar, commented out since not hooked up to anything yet
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "showProjects" {
        //            let showProjects:ProjectsViewController = segue.destinationViewController as! ProjectsViewController
        //        }
        //        if segue.identifier == "showNew" {
        //            let showNew:NewViewController = segue.destinationViewController as! NewViewController
        //        }
        //        if segue.identifier == "showArchive" {
        //            let showArchive:ArchiveViewController = segue.destinationViewController as! ArchiveViewController
        //        }
        //        if segue.identifier == "showSettings" {
        //            let showSettings:SettingsViewController = segue.destinationViewController as! SettingsViewController
        //        }
    }
}
