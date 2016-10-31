//
//  SingleComponentPickerViewController.swift
//  KR
//
//  Created by Philron William Hozier on 10/15/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import UIKit

// implementing using an array to mock a data source.

class SingleComponentPickerViewController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource  {
// we now much implement the required picker methods
// we implement this controller both as data source and a delegate
    
    @IBOutlet var singlePicker: UIPickerView!
    @IBOutlet var Select: UIButton!
    
    private static func getNames() -> [String]{
        return ["Luke", "Leia", "Han", "Chewbacca",
            "Artoo", "Threepio", "Lando"
        ]
    }
    
    private let characterNames = SingleComponentPickerViewController.getNames()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonPressed(sender: AnyObject) {
        // refers to which spiining wheel inside the picker
        // because there is only one spinning wheel
        // we choose 0
        let row = singlePicker.selectedRowInComponent(0)
        
        let selected = characterNames[row]
        let title = "You selected \(selected)"
        
        let alert = UIAlertController(title: title,
            message: "Thank you for choosing",
            preferredStyle: .Alert)
        
        let action = UIAlertAction(
            title: "You're welcome",
            style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // overview: these three mthods are required to implement the picker
    // defines how many spinning wheels the picker should display
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // asks the picker how many different data source rows are there for said spinning wheel
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterNames.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characterNames[row]
    }
    

}
