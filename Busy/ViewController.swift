//
//  ViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 13/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userObject: User?
    // this is the user object that will be used throughout the application henceforth
    let rootRef = FIRDatabase.database().reference()
    var data = [String:AnyObject]()
    var projects = [String:AnyObject]()
    var tasks = [String:AnyObject]()
    var displayList = [String:[ AnyObject]]()
    // a dictionary of deadline:[item], where item can be a project or a task (i.e. another [String:AnyObject], so essentially deadline:[[String:AnyObject]])
    var currentDate = Date()
    var newDateComponents = DateComponents()
    var itemsToDisplay = [AnyObject]()

    
    @IBOutlet var agendaTableView: UITableView!
    @IBOutlet var timeframeSegment: UISegmentedControl!
    @IBOutlet var tabBar: UITabBar!
    
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
        
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        agendaTableView?.register(cellNib, forCellReuseIdentifier: "agendaViewCell")
        self.agendaTableView?.reloadData()
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
        self.agendaTableView?.reloadData()
    }
    
    // MARK: - Database retrieval
    
/*
 For reading data from the Firebase database, provide it with a reference location (as above)
 
 observe(Event) will continuously monitor the database location for any changes,
 such that any changes made to the child data at said location will be 'immediately' reflected in the view
 */
    override func viewDidAppear(_ animated: Bool) {
        rootRef.observe(FIRDataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.data = dataDict
            
            self.parseDataDict()
            self.determineTableValues()
            self.agendaTableView?.reloadData()
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
    
    /* 
     Store all items (in this case, projects and tasks) in a single array (displayItems), with the key being the item's deadline. When loading the data for the agenda table view, take displayItems and filter.
     */
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
    
    // MARK:- Working with dates

    
//    func convertCurrentDate() {
//        let dateFormatter2 = DateFormatter()
//        dateFormatter2.timeStyle = .none // strips time from string
//        dateFormatter2.dateStyle = .medium
//        let stringCurrent = dateFormatter2.string(from: currentDate as Date) // returns currentDate as date only, no time
//        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat = "EEEE, MMMM dd, yyyy" // EEEE is Day of week
//        let todayNSDate = dateFormatter3.date(from: stringCurrent)
//        // converts currentDate back to NSDate object for comparison
//        currentDate = todayNSDate!
//        let locale = Locale.current
//        var calendar = Calendar.Identifier(locale)
//        let dateComponents = Calendar.dateComponents(Calendar.current)
//            //.dateComponents([.day, .month, .year], from: currentDate)
//        var newDateComponents = DateComponents()
//        newDateComponents.day = 7
//        dateInWeek = Calendar.current.date(byAdding: newDateComponents, to: currentDate)!
//        // sets dateInWeek to 7 days from currentDate
//    }
    
    /*
     Convert each deadline string to an NSDate object, and compare; using separate function for each 'tab' (due today / this week / all items)
     */

    func convertDeadline(deadline: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // EEEE is Day of week
        let deadlineNSDate = dateFormatter.date(from: deadline)
        return deadlineNSDate!
    }
    
    // MARK:- Filters for chosen segment
    var todayList = [AnyObject]()
    func filterForToday(){
        todayList = []
        for deadline in displayList.keys{
            if deadline == "NA" {continue} // skip items where deadline not set
            else {
                let deadlineNSDate = convertDeadline(deadline: deadline)
                if deadlineNSDate <= currentDate{
                    for itemDictionary in displayList[deadline]! {
                        todayList.append(itemDictionary)
                    }
                }
            }
        }
    }

    var weekList = [AnyObject]()
    func filterForWeek(){
        weekList = []
        for deadline in displayList.keys{
            if deadline == "NA" {continue} // skip items where deadline not set
            else {
                let deadlineNSDate = convertDeadline(deadline: deadline)
                newDateComponents.day = 7
                let dateInWeek = Calendar.current.date(byAdding: newDateComponents, to: currentDate)!
                if deadlineNSDate <= dateInWeek{
                    for itemDictionary in displayList[deadline]! {
                        weekList.append(itemDictionary)
                    }
                }
            }
        }
    }
    
    var allList = [AnyObject]()
    func noFilter(){
        allList = []
        for deadline in displayList.keys{
            for itemDictionary in displayList[deadline]! {
                allList.append(itemDictionary)
            }
        }
    }

    func determineTableValues(){
        switch timeframeSegment.selectedSegmentIndex
        {
        case 0:
            print("Today selected");
            filterForToday();
            itemsToDisplay = todayList
        case 1:
            print("This Week selected");
            filterForWeek();
            itemsToDisplay = weekList
        case 2:
            print("All Items selected");
            noFilter();
            itemsToDisplay = allList
        default:
            break;
        }
    }
    
    // MARK:- Delegate functions for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsToDisplay.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = agendaTableView.dequeueReusableCell(withIdentifier: "agendaViewCell", for: indexPath as IndexPath) as! TableViewCell
        
        let item = itemsToDisplay[indexPath.row] as? [String:AnyObject] ?? [:]
        //let deadlineString = projectAttributes["projectDeadline"] as! String
        
        // probably ought to format the date string nicely
        
        //cell.Due.text = deadlineString
        if let titleString = item["projectTitle"] as? String {
            cell.Title.text = titleString
        } else {
            let titleString = item["taskTitle"] as! String
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

