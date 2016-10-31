//
//  DoubleComponentPickerViewController.swift
//  KR
//
//  Created by Philron William Hozier on 10/15/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource
{
    

    @IBOutlet var doublePicker: UIPickerView!
    
    //Picker components are referred to by number, with the leftmost component 
    //being assigned zero and increasing
    //by one each move to the right.
    private let fillingComponent = 0
    private let breadComponent = 1
    private let fillingTypes = DoubleComponentPickerViewController
        .getNames()["filling"]
    
    private let breadTypes = DoubleComponentPickerViewController
        .getNames()["bread"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func getNames() -> [String: [String]]{
        var lookup = [String: [String]]()
        lookup["filling"] = ["Uniqlo", "Zara", "Hennes & Mauritz AB", "Will Leather Goods",
            "Urban Outfitters", "Free People", "Home"]
        
        lookup["bread"] = [
            "Skinny Jeans", "Bomber Jacket", "Supreme Hat", "Suit & Tie",
            "Mystery"]
        return lookup
    }
    
    // adding data source and delegate methods below
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (component == breadComponent) ? breadTypes!.count : fillingTypes!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == breadComponent ? breadTypes![row] : fillingTypes![row]
    }

    @IBAction func onButtonPressed(sender: AnyObject) {
        let fillingRow = doublePicker.selectedRowInComponent(fillingComponent)
        let breadRow = doublePicker.selectedRowInComponent(breadComponent)
                
        let filling = fillingTypes![fillingRow]
        let bread = breadTypes![breadRow]
        
        let message = "Your \(bread) from \(filling) will be delivered shortly."
        
        let alert = UIAlertController(
                title: "Thank you for your order", message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Great", style: .Default, handler: nil )
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
