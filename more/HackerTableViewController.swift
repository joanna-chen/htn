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

        let url = NSURL(string: self.json[indexPath.row]["picture"].stringValue)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
            cell.imageView!.image = UIImage(data: data!)
            cell.imageView!.layer.cornerRadius = cell.imageView!.frame.size.width / 2;
            cell.imageView!.clipsToBounds = true
        }
        
        var str : String = ""
        let skills = self.json[indexPath.row]["skills"]
        
        for (var i=0 ; i < skills.count ; i++) {
            var name = skills[i]["name"].stringValue
            var rating = skills[i]["rating"].intValue
            
            if (i == skills.count-1) {
                str = str + " \(name) \(rating)"
            } else {
                str = str + " \(name) \(rating) •"
            }
        }
        
        cell.label.numberOfLines = 2
        cell.label.text = self.json[indexPath.row]["name"].stringValue + "\n" + str

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selected = indexPath.row
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! DetailViewController
        destination.dataJSON = self.json[selected]
        destination.populate()
    }

}
