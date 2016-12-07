//
//  ViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 13/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit
// add firebase

class ViewController: UIViewController {

    @IBOutlet var agendaTableView: UITableView!
    @IBOutlet var timeframeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        if segue.identifier == "showProjects" {
            let showProjects:ProjectsViewController = segue.destinationViewController as! ProjectsViewController
        }
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

