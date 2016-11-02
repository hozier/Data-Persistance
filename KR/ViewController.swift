//
//  ViewController.swift
//  Persistence
//
//  Created by James Morris on 11/1/16.
//  Copyright © 2016 James Morris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private static let rootKey = "rootKey"
    @IBOutlet var lineFields:[UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileURL = self.dataFileURL()
        if(NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)) {
            if let array = NSArray(contentsOfURL: fileURL) as? [String] {
                for var i = 0; i < array.count; i++ {
                    lineFields[i].text = array[i]
                }
            }
            
            let data = NSMutableData(contentsOfURL: fileURL)!
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            let fourLines = unarchiver.decodeObjectForKey(ViewController.rootKey) as! FourLines
            unarchiver.finishDecoding()
            
            if let newLines = fourLines.lines {
                for var i = 0; i < newLines.count; i++ {
                    lineFields[i].text = newLines[i]
                }
            }
        }
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataFileURL() -> NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        return urls.first!.URLByAppendingPathComponent("data.archive")
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        let fileURL = self.dataFileURL()
        let fourLines = FourLines()
        let array = (self.lineFields as NSArray).valueForKey("text") as! [String]
        fourLines.lines = array
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(fourLines, forKey: ViewController.rootKey)
        archiver.finishEncoding()
        
        data.writeToURL(fileURL, atomically: true)
    }
    

}

