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
    
    var order:String!
    var store:String!
    @IBOutlet var banner: UILabel!
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
    

    // 0
    func dataFilePath() -> String{
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory,
            inDomains: .UserDomainMask)
        
        return urls.first!.URLByAppendingPathComponent("data.plist").path!
    }
    
    // 1
    override func viewDidLoad() {
        super.viewDidLoad()

        var database:COpaquePointer = nil
        var result = sqlite3_open(dataFilePath(), &database)
        
        // error handling and mem deallocation
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
            return
        }
        
        
        // create schema for db
        let createSQL = "CREATE TABLE IF NOT EXISTS FIELDS " +
        "(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);"
        
        
        /*
        The function sqlite3_exec is used to run any command against SQLite3 that doesn’t return data, including updates, inserts, and deletes.
        */
        var errMsg:UnsafeMutablePointer<Int8> = nil
        result = sqlite3_exec(database, createSQL, nil, nil, &errMsg)
        if (result != SQLITE_OK) {
            sqlite3_close(database)
            print("Failed to create table")
            return
        }
        
        // run a query
        let query = "SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW"
        var statement:COpaquePointer = nil
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let row = Int(sqlite3_column_int(statement, 0))
                let rowData = sqlite3_column_text(statement, 1)
                let fieldValue = String.fromCString(UnsafePointer<CChar>(rowData))
            banner.text = fieldValue!
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
        
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "applicationWillResignActive:",
                name: UIApplicationWillResignActiveNotification,
                object: app)
        
        
    }
    
    // 3
    func applicationWillResignActive(notification:NSNotification) {
            var database:COpaquePointer = nil
            let result = sqlite3_open(dataFilePath(), &database)
            if result != SQLITE_OK {
                sqlite3_close(database)
                print("Failed to open database")
                return
            }
            
                let update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) " +
                    "VALUES (?, ?);"
                var statement:COpaquePointer = nil
            
                if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
                
                    let text = "Last order purchased: \(order) from \(store)"
                
                    sqlite3_bind_int(statement, 1, Int32(0))
                    sqlite3_bind_text(statement, 2, text, -1, nil)
                }
            
                if sqlite3_step(statement) != SQLITE_DONE {
                    print("Error updating table")
                    sqlite3_close(database)
                    return
                }
            
            sqlite3_finalize(statement)
            
        sqlite3_close(database)
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
                
        order = bread
        store = filling
        
        let message = "Your \(bread) from \(filling) will be delivered shortly."
        
        let alert = UIAlertController(
                title: "Thank you for your order", message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Great", style: .Default, handler: nil )
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
