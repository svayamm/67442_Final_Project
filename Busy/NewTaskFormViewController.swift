//
//  NewTaskFormViewController.swift
//  Busy
//
//  Created by j w on 12/13/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftForms

class NewTaskFormViewController: FormViewController {
    
    let currentFUID = FIRAuth.auth()?.currentUser?.uid
    
    
    // From examplar code provided by SwiftForms
    struct Static {
        static let title = "title"
        static let deadline = "deadline"
        static let button = "button"
        static let projectID = "projectID"
        static let description = "description"
        static let complete = "complete"
        static let priority = "priority"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(NewFormViewController.submit(_:)))
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        print(self.form.formValues()["title"])
        
        let alertController = UIAlertController(title: "Form output", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alertController.addAction(cancel)
        
        //self.present(alertController, animated: true, completion: nil)
        
        weak var weakSelf = self // required to fix 'implicit use of self in closure' error
        weakSelf?.performSegue(withIdentifier: "NewTask", sender: self)
    }
    
    // MARK: New Project Form interface, using SwiftForms lib
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "New Task Form")
        
        let section1 = FormSectionDescriptor(headerTitle: "Task Information:", footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.title, type: .text, title: "Task Title")
        row.configuration.cell.appearance = ["textField.placeholder" : "Task Name" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.description, type: .multilineText, title: "Description")
        row.configuration.cell.appearance = ["textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.description, type: .booleanSwitch, title: "Complete")
        row.configuration.cell.appearance = ["textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.description, type: .picker, title: "projectID")
        row.configuration.cell.appearance = ["textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.description, type: .picker, title: "Priority")
        row.configuration.cell.appearance = ["textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: "Optional input:", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.deadline, type: .date, title: "Due Date")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)
        

        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.button, type: .button, title: "Cancel")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
            //            // Create a new "NewProjectTypes" instance.
            //            let storyboard = UIStoryboard(name: "NewProjectTypes", bundle: nil)
            //
            //            // Create an instance of the storyboard's initial view controller.
            // change to correct identifier
            //            let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
            //
            //            // Display the new view controller.
            //             weak var weakSelf = self // required to fix 'implicit use of self in closure' error
            //            weakSelf?.present(controller, animated: true, completion: nil)
            
        }
        section3.rows.append(row)
        
        form.sections = [section1, section2, section3]
        
        self.form = form
    }
    
    func createTask() -> [String: Any]{
        
        let filledForm = self.form.formValues()
        let UUID = NSUUID.init().uuidString
        var complete = filledForm["complete"]
        // User-generated values
        let taskTitle = filledForm["title"]
        let description = filledForm["description"]
        // converting NSDate to String
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        var convertedDate = dateFormatter.string(from: filledForm["deadline"] as! Date)
        let taskDeadline = convertedDate
        let priority = filledForm["priority"]
        let projectID = filledForm["projectID"]
        let taskDict = ["taskTitle":taskTitle,"description": description, "taskDeadline": taskDeadline, "priority": priority, "id": UUID,  "complete":complete, "projectID":projectID] as [String : Any]
        // dictionary of project info created, to be passed into database
        return taskDict
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewTask"
        {
            if let destinationVC = segue.destination as?  DetailsViewController {
                // INCLUDE OTHER MODEL PROPERTIES; TRIAL ONLY
                let dict = self.createTask()
                let projectID = dict["id"] as! String
                let userProjectsRef = FIRDatabase.database().reference().child("task").child(currentFUID!).child(projectID)
                userProjectsRef.updateChildValues(dict, withCompletionBlock: {
                    (err, ref) in
                    
                    if err != nil {
                        print(err ?? "Error could not be cast as string")
                        return}
                    
                    print("Successfully saved task in FIR Database")
                })
                destinationVC.projectUUID = projectID
            }
        }
    }
}
