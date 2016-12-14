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
    var data = [String:AnyObject]()
    var projects = [String:AnyObject]()
    var tasks = [String:AnyObject]()
    var displayList = [String:[ AnyObject]]()
    var currentDate = NSDate()
    var dateInWeek: NSDate

    
    @IBOutlet var agendaTableView: UITableView!
    @IBOutlet var timeframeSegment: UISegmentedControl!
    @IBOutlet var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        convertCurrentDate()

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
    
    // MARK: - Database retrieval
    override func viewDidAppear(_ animated: Bool) {
        rootRef.observe(FIRDataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.data = dataDict
            
            self.parseDataDict()
            //self.tableView?.reloadData()
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
            let newItems = existingItems.append(project.value)
            displayList[deadline] = newItems
        }
        //self.tableView?.reloadData()
    }
    func parseTasksList() {
        for task in tasks {
            let deadline = task.value["taskDeadline"] as? String ?? "NA"
            var existingItems = displayList[deadline] as [AnyObject]? ?? []
            let newItems = existingItems.append(task.value)
            displayList[deadline] = newItems
        }
    }
    
    // MARK:- Working with dates

    
    func convertCurrentDate() {
        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeStyle = DateFormatterStyle.NoStyle // strips time from string
        dateFormatter2.dateStyle = NSDateFormatterStyle.MediumStyle
        print(dateFormatter2.stringFromDate(currentDate)) // returns currentDate as date only, no time
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "EEEE, MMMM dd, yyyy" // EEEE is Day of week
        let todayNSDate = dateFormatter3.dateFromString(currentDate)
        // converts currentDate back to NSDate object for comparison
        currentDate = todayNSDate
        let newDateComponents = NSDateComponents()
        newDateComponents.day = 7
        dateInWeek = NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
        // sets dateInWeek to 7 days from currentDate
    }

    func convertDeadline(deadline: String)->NSDate{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // EEEE is Day of week
        let deadlineNSDate = dateFormatter.dateFromString(deadline)
        return deadlineNSDate
    }
    
    // MARK:- Filters for chosen segment
    var todayList = [AnyObject]()
    func filterForToday(){
        for deadline in displayList.keys{
            if deadline == "NA" {continue} // skip items where deadline not set
            else {
                deadlineNSDate = convertDeadline(deadline)
                if deadlineNSDate == deadlineNSDate.earlierDate(currentDate){
                    for itemDictionary in deadline.values {
                        todayList.append(itemDictionary)
                    }
                }
            }
        }
    }
    
    var weekList = [AnyObject]()
    func filterForWeek(){
        for deadline in displayList.keys{
            if deadline == "NA" {continue} // skip items where deadline not set
            else {
                deadlineNSDate = convertDeadline(deadline)
                if deadlineNSDate == deadlineNSDate.earlierDate(dateInWeek){
                    for itemDictionary in deadline.values {
                        weekList.append(itemDictionary)
                    }
                }
            }
        }
    }
    

    func determineTableValues(){
        switch timeframeSegment.selectedSegmentIndex
        {
        case 0:
            print("Today selected");
            filterForToday();
            
        case 1:
            print("This Week selected");
            filterForWeek()
        case 2:
            print("All Items selected");
        default:
            break;
        }
    }
    
    
}

