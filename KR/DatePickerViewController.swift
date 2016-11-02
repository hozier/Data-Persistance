//
//  DatePickerViewController.swift
//  KR
//
//  Created by Philron William Hozier on 10/15/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    // outlet == a visible object on the view which can be pressed, etc
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var Select: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let date = NSDate()
        //datePicker.setDate(date, animated: false)
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

    @IBAction func onButtonPressed(sender: AnyObject) {
        let date = datePicker.date
        let message = "The date and time you selected is \(date)"
        
        // displays (the body) of the alert popup
        let alert = UIAlertController(
            title: "Date and Time Selected",
            message: message,
            preferredStyle: .Alert)
        
        // displays the (action button) of the alert popup
        let action = UIAlertAction(
            title: "That's so cool",
            style: .Default,
            handler: nil)
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
}
