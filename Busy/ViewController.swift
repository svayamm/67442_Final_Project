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
    
    var userObject = User(firebaseUID: "", displayName: "", email: "")
    // this is the user object that will be used throughout the application henceforth

    
    @IBOutlet var test: UIButton!
    @IBOutlet var agendaTableView: UITableView!
    @IBOutlet var timeframeSegment: UISegmentedControl!
    @IBOutlet var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //tabBar.selectedItem = (tabBar.items?[0])! as UITabBarItem;
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("button!!\n\n\n")
        let alert = UIAlertController(title: "Testing userObject and FirebaseUser", message: generateMessage(), preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
    }
    
    func generateMessage() -> String {
        //let userF = FIRAuth.auth()?.currentUser
            let message = "User Object Details: \n  (\(userObject.displayName), \(userObject.email))>"
            return message
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
 //       if segue.identifier == "showProjects" {
  //          let showProjects:ProjectsViewController = segue.destination as! ProjectsViewController
 //       }
//        if segue.identifier == "showNew" {
//            let showNew:NewViewController = segue.destinationViewController as! NewViewController
//        }
//        if segue.identifier == "showArchive" {
//            let showArchive:ArchiveViewController = segue.destinationViewController as! ArchiveViewController
//        }
//        if segue.identifier == "showProfile" {
 //           let showProfile:UserProfileViewController = segue.destination as! UserProfileViewController
 //       }
    }
}

