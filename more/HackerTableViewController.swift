//
//  HackerTableViewController.swift
//  more
//
//  Created by Joanna Chen on 2016-02-29.
//  Copyright © 2016 Joanna Chen. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Alamofire

class HackerTableViewController: UITableViewController {
    
    var json : JSON!
    var selected = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        //format nav bar colour
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.translucent = false
        //format nav bar title
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        //format nav bar title
        self.navigationItem.title = "Hack The North"
        
        
        let url = NSURL(string: "https://htn-interviews.firebaseio.com/users.json")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            if let dataFromString = str!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                self.json = JSON(data: dataFromString)
//                print(self.json[0]["name"])
//                self.json.sort({$0["name"] <  $1["name"]})
                self.tableView.reloadData();
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let newJson = json{
            return newJson.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hackerCell", forIndexPath: indexPath) as! HackersTableViewCell

        let url = self.json[indexPath.row]["photo"].stringValue
        
        cell.label.text = self.json[indexPath.row]["name"].stringValue
        //cell.imageView?.image = UIImage(data: NSData(contentsOfFile: url)!)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selected = indexPath.row
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! DetailViewController
        print(self.json[selected])
        destination.dataJSON = self.json[selected]
        destination.populate()
    }

}
