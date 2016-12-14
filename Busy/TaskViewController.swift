//
//  TaskViewController.swift
//  Busy
//
//  Created by j w on 12/13/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tasksRef = FIRDatabase.database().reference().child("tasks").child((FIRAuth.auth()?.currentUser?.uid)!)
    var taskList = [String:AnyObject]()
    var titleAsKey = [String:[String:AnyObject]]()
    var titleIndex = [String]()
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cellNib = UINib(nibName: "UPTaskTableViewCell", bundle: nil)
        tableView?.register(cellNib, forCellReuseIdentifier: "taskListCell")
        // get the data for the table
        //parseProjectList()
        self.tableView?.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(taskList.count) THIS HERE")
        return self.taskList.count;
    }
    func parseTaskList(){
        print("pls")
        print(taskList.count)
        for task in taskList{//should do if tasklist.count != 0
            print("task")
            let title = task.value["taskTitle"] as! String
            print(title)
            titleAsKey[title] = task.value as? [String : AnyObject]
        }
        let sortedTitles = Array(titleAsKey.keys).sorted(by: <)
        var indexKey = 0
        for sortedTitle in sortedTitles {
            print(sortedTitle)
            titleIndex.append(sortedTitle)
            indexKey+=1
        }
        self.tableView?.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell:UITableViewCell = (self.tableView?.dequeueReusableCell(withIdentifier: "cell"))! as UITableViewCell
        print("ew")
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskListCell", for: indexPath as IndexPath) as! UPTaskTableViewCell
        print(indexPath.row, titleIndex.count)
        let taskName = titleIndex[indexPath.row]
        let taskAttributes = titleAsKey[taskName]! as [String:AnyObject]
        //let deadlineString = projectAttributes["projectDeadline"] as! String
        
        // probably ought to format the date string nicely
        
        //cell.Due.text = deadlineString
        cell.TaskName?.text = "TEXT HERE"
            //taskAttributes["taskTitle"] as! String
        //cell.taskCount = proj.tasks.count
        //cell.textLabel?.text = self.projectList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("hello")
        tasksRef.observe(FIRDataEventType.value, with: { (snapshot) in
            // snapshot.children = all projects listed under FUID
            //self.projectList.removeAll()
            let taskList = snapshot.value as? [String : AnyObject] ?? [:]
            self.taskList = taskList
            print("world")
            self.parseTaskList()
            self.tableView?.reloadData()
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
