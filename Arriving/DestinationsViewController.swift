//
//  ViewController.swift
//  Arriving
//
//  Created by Roger on 6/27/15.
//  Copyright (c) 2015 Roger. All rights reserved.
//

import UIKit

class DestinationsViewController: UITableViewController {
    
    var destinations: [Destination] = []
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
//        if self.destinations.count != 0 {
//            aCoder.encodeObject(destinations, forKey: "destinations")
//        }
    }
    
    override func awakeFromNib() {
        loadDestination()
    }
    
    func loadDestination() {
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("destinations")
        if let object: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("destinations") {
            let dst: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(object as! NSData)
            if let dst: AnyObject = dst {
                destinations = dst as! [Destination]
            }
        }
    }
    func saveDestination() {
        if destinations.count != 0 {
            let data = NSKeyedArchiver.archivedDataWithRootObject(destinations)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "destinations")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Destination", forIndexPath: indexPath) as! UITableViewCell
        let destination = destinations[indexPath.row] as Destination
        cell.textLabel!.text = destination.title
        return cell
    }
   

    //MARK: - prepare segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //unwrap the MapViewController if it's embled in navigation controller
//        var destination = segue.destinationViewController as? UIViewController
//        if let navCon = destination as? UINavigationController {
//            destination = navCon.visibleViewController
//        }
//        if let hvc = destination as? MapViewController {
//            if let identifier = segue.identifier {
//                
//            }
//        }
    }
    
}

