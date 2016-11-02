//
//  DependentComponentPickerViewController.swift
//  KR
//
//  Created by Philron William Hozier on 10/15/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import UIKit

class CoreDataViewController: UIViewController {

    @IBOutlet weak var lineOneTextField: UITextField!
    @IBOutlet weak var lineTwoTextField: UITextField!
    @IBOutlet weak var lineOneLabel: UILabel!
    @IBOutlet weak var lineTwoLabel: UILabel!
    
    @IBAction func commitToPersistence(sender: UIButton) {
        
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
