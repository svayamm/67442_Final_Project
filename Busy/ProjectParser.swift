
    /* 
     // code for table views, specifically agenda
     
     Store all items (in this case, projects and tasks) in a single array (displayItems), with the key being the item's deadline. When loading the data for the agenda table view, take displayItems and filter.
     
     let displayItems: [String:AnyObject]
     
     
     // MARK:- Filtering ####
     
     For filtering: Convert each deadline string to an NSDate object, and compare; using separate function for each 'tab' (due today / this week / all items)
      -- Strip time from deadline!
     
     
     convertDeadline(deadline)->NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // EEEE is Day of week
        let deadlineNSDate = dateFormatter.dateFromString(deadline)
        
     
     let currentDate = NSDate()
     let dateFormatter2 = NSDateFormatter()
     dateFormatter2.timeStyle = NSDateFormatterStyle.NoStyle // strips time from string
     dateFormatter2.dateStyle = NSDateFormatterStyle.MediumStyle
     print(dateFormatter2.stringFromDate(currentDate)) // returns currentDate as date only, no time
     let dateFormatter3 = DateFormatter()
     dateFormatter3.dateFormat = "EEEE, MMMM dd, yyyy" // EEEE is Day of week
     let todayNSDate = dateFormatter3.dateFromString(currentDate)
     // converts currentDate back to NSDate object for comparison
     
     // for due this week, add 7 days to currentDate and repeat process of converting to string,
     // stripping time, converting back to date nextWeekNSDate
     
     filtering function example: for 'due today'
     for deadline in displayItems
            deadlineNSDate = convertDeadline(deadline)
            if deadlineNSDate <= todayNSDate:
                // add deadline.values to displayItems
     
     
    
     
    // a dictionary of deadline:[item], where item can be a project or a task (i.e. another [String:AnyObject], so essentially deadline:[[String:AnyObject]])
    
    //////////////////////////////////////////
    // MARK:- adding items to display list
     
     create 2 add functions: addProject(items: Dictionary, item: dictionary) and addTask
     both add to displayItems
     // if no value exists at key (key being the deadline timestamp string)
    
     displayItems[deadline] = project / task    
     // i.e. displayItems[deadline] is the set of project (or task) dictionaries, such that each
     // value of the set is a project/task=[attributes:attributeValues]
     // IS THERE A BETTER WAY TO DO THIS?? DISCUSS
    
     // if there is a preexisting item for a given deadline
    
     var existingItems = displayItems[deadline] // gets dictionary of items due on a given day
     
    */
    
    // let userProjectsRef = FIRDatabase.database().reference().child("projects").child((FIRAuth.auth()?.currentUser?.uid)!)

/*    
     For reading data from the Firebase database, provide it with a reference location (as above)
     
     observeEvent will continuously monitor the database location for any changes,
     such that any changes made to the child data at said location will be 'immediately' reflected
     
     one can also use observeSingleEvent, which will read the location once and return
     the required values. This
     
     userProjectsRef.observe(FIRDataEventType.value, with: { (snapshot) in
        // snapshot.children = all projects listed under FUID
        let projectDictionary = snapshot.value as? [String : AnyObject] ?? [:]
        for project in projectDictionary {
            if let deadline = project.value["projectDeadline"] {
                addProject(displayItems[deadline], project)
            }
    }
    }) */

/*
    For writing data to the database, 
 
 
 
 
 
 */
