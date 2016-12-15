//
//  ArchiveViewController.swift
//  Busy
//
//  Created by j w on 12/7/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ArchiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userObject: User?
    // this is the user object that will be used throughout the application henceforth
    let rootRef = FIRDatabase.database().reference()
    var data = [String:AnyObject]()
    var projects = [String:AnyObject]()
    var tasks = [String:AnyObject]()
    var displayList = [String:[ AnyObject]]()
    var itemsToDisplay = [AnyObject]()
    
    
    @IBOutlet var archiveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //convertCurrentDate()
        
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
        idRef.updateChildValues(userDict, withCompletionBlock: { // can only be called in view function
            (err, ref) in
            
            if err != nil {
                print(err ?? "Error could not be cast as string")
                return}
            
            print("Successfully saved user in FIR Database")
        })
        
        let cellNib = UINib(nibName: "ArProjectTableViewCell", bundle: nil)
        archiveTableView?.register(cellNib, forCellReuseIdentifier: "arViewCell")
        self.archiveTableView?.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segmented Control
    
    // for the segmented control on top
    @IBAction func indexChanged(sender:UISegmentedControl)
    {
        determineTableValues()
        self.archiveTableView?.reloadData()
    }
    
    // MARK: - Database retrieval
    override func viewDidAppear(_ animated: Bool) {
        rootRef.observe(FIRDataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.data = dataDict
            
            self.parseDataDict()
            self.determineTableValues()
            self.archiveTableView?.reloadData()
        })
        
    }
    func parseDataDict(){
        let userFID = FIRAuth.auth()?.currentUser?.uid
        guard let allProjects = data["projects"] as? [String:AnyObject] else {print("Could not unwrap projects"); return}
        let userProjects = allProjects[userFID!] as? [String:AnyObject] ?? [:]
        self.projects = userProjects
        parseProjectList()
        
        guard let allTasks = data["tasks"] as? [String:AnyObject] else {print("Could not unwrap tasks"); return}
        let userTasks = allTasks[userFID!] as? [String:AnyObject] ?? [:]
        self.tasks = userTasks
        parseTasksList()
        
    }
    func parseProjectList(){
        for project in projects {
            let deadline = project.value["projectDeadline"] as? String ?? "NA"
            var existingItems = displayList[deadline] as [AnyObject]? ?? []
            existingItems.append(project.value)
            let newItems = existingItems
            displayList[deadline] = newItems
        }
        //self.tableView?.reloadData()
    }
    func parseTasksList() {
        for task in tasks {
            let deadline = task.value["taskDeadline"] as? String ?? "NA"
            var existingItems = displayList[deadline] as [AnyObject]? ?? []
            existingItems.append(task.value)
            let newItems = existingItems
            displayList[deadline] = newItems
        }
    }
    
    
    // MARK:- Filters
    
    var allList = [AnyObject]()
    func compFilter(){
        allList = []
        for deadline in displayList.keys{
            for itemDictionary in displayList[deadline]! {
                if let comp = itemDictionary["completed"] as? Int {
                    if comp == 1 {
                        allList.append(itemDictionary)
                    }
                }
            }
        }
    }
    
    func determineTableValues(){
        compFilter();
        itemsToDisplay = allList
    }
    
    // MARK:- Delegate functions for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsToDisplay.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: "arViewCell", for: indexPath as IndexPath) as! ArProjectTableViewCell
        
        let item = itemsToDisplay[indexPath.row] as? [String:AnyObject] ?? [:]
        //let deadlineString = projectAttributes["projectDeadline"] as! String
        
        // probably ought to format the date string nicely
        
        //cell.Due.text = deadlineString
        if let titleString = item["projectTitle"] as? String {
            cell.Title.text = titleString
        }
        //cell.Title?.text = item["projectTitle"] ?? item["taskTitle"]
        //cell.taskCount = proj.tasks.count
        //cell.textLabel?.text = self.projectList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

