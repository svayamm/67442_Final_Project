//
//  ProjectsViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 13/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
// add firebase



// check authentication state, call functions for filtering table and actions if authenticated
import UIKit
import Firebase

class ProjectsViewController: UIViewController {
    let projectsRef = FIRDatabase.database().reference().child("projects").child((FIRAuth.auth()?.currentUser?.uid)!)
    var projectList = [String:AnyObject]()
    var titleAsKey = [String:[String:AnyObject]]()
    var titleIndex = [String]()
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectList.count;
    }
    func parseProjectList(){
        
        for project in projectList{
            let title = project.value["projectTitle"] as! String
            titleAsKey[title] = project.value as? [String : AnyObject]
            let sortedTitles = Array(titleAsKey.keys).sorted(by: <)
            var indexKey = 0
            for sortedTitle in sortedTitles {
                titleIndex.append(sortedTitle)
                indexKey+=1
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell:UITableViewCell = (self.tableView?.dequeueReusableCell(withIdentifier: "cell"))! as UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ProjectTableViewCell
        let projName = titleIndex[indexPath.row]
        let projectAttributes = titleAsKey[projName]! as [String:AnyObject]
        let deadlineString = projectAttributes["projectDeadline"] as! String

        // probably ought to format the date string nicely
        
        cell.Due.text = deadlineString
        cell.Title.text = projectAttributes["projectTitle"] as! String
        //cell.taskCount = proj.tasks.count
        //cell.textLabel?.text = self.projectList[indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    override func viewDidAppear(_ animated: Bool) {
        projectsRef.observe(FIRDataEventType.value, with: { (snapshot) in
            // snapshot.children = all projects listed under FUID
            self.projectList.removeAll()
            let projList = snapshot.value as? [String : AnyObject] ?? [:]
            self.projectList = projList
//            for project in snapshot.value as? Dictionary {
//                self.projectList.append(project)
//            }
        })
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
