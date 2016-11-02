//
//  DependentComponentPickerViewController.swift
//  KR
//
//  Created by Philron William Hozier on 10/15/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    

    @IBOutlet weak var lineOneTextField: UITextField!
    @IBOutlet weak var lineTwoTextField: UITextField!
    @IBOutlet weak var lineOneLabel: UILabel!
    @IBOutlet weak var lineTwoLabel: UILabel!
    
    @IBAction func commitToPersistence(sender: UIButton) {
        // create an instance of our managedObjectContext
        let managedobjcontext = DataController().managedObjectContext
        
        //clear context before recommitting
        let linesFetch = NSFetchRequest(entityName: "Lines")
        
        do {
            let fetchedLines = try managedobjcontext.executeFetchRequest(linesFetch) as! [Lines]
            
            for linesObj in fetchedLines {
                managedobjcontext.deleteObject(linesObj)
            }
            
        } catch {
            fatalError("Failed to fetch Lines (due to coredata issue: \(error)")
        }
        //the code in here is for clearing the context
        
        
        
        //creates a managed object instance
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Lines", inManagedObjectContext: managedobjcontext) as! Lines
        
        // add our data
        entity.setValue(lineOneTextField.text, forKey: "line1")
        entity.setValue(lineTwoTextField.text, forKey: "line2")
        
        // we save our entity
        do {
            try managedobjcontext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    @IBAction func pullFromPersistence(sender: UIButton) {
        
        let managedobjcontext = DataController().managedObjectContext
        let linesFetch = NSFetchRequest(entityName: "Lines")
        
        do {
            let fetchedLines = try managedobjcontext.executeFetchRequest(linesFetch) as! [Lines]
            
            lineOneLabel.text = fetchedLines.first!.line1
            lineTwoLabel.text = fetchedLines.first!.line2
            
        } catch {
            fatalError("Failed to fetch Lines (due to coredata issue: \(error)")
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
