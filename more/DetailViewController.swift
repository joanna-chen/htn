//
//  DetailViewController.swift
//  more
//
//  Created by Joanna Chen on 2016-02-29.
//  Copyright © 2016 Joanna Chen. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var skills: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var dataJSON : JSON!
    var str : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        //format nav bar colour
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.translucent = false
        //format nav bar title
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        nameLabel?.text = dataJSON["name"].stringValue
        company?.text = dataJSON["company"].stringValue
        phone?.text = dataJSON["phone"].stringValue
        email?.text = dataJSON["email"].stringValue
        
        
        let s : JSON! = dataJSON["skills"]
        var i : Int = 0
        skills?.numberOfLines = s.count
        
        while (i <= s.count) {
            var name = s[i]["name"].stringValue
            var rating = s[i]["rating"].intValue
            
            if (i == s.count-1) {
                str = str + "\(name): \(rating)"
                skills?.text = str
            } else {
                str = str + "\(name): \(rating) \n"
            }
            
            i += 1
        }
        
        mapView.delegate = self
        let latitude = dataJSON["latitude"].doubleValue
        let longitude = dataJSON["longitude"].doubleValue
        //print(latitude,longitude)
        let center = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)

        let url = NSURL(string: dataJSON["picture"].stringValue)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
            imageView.image = UIImage(data: data!)
            self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
            self.imageView.clipsToBounds = true;
        }

    }
    
    func populate() {
        self.navigationItem.title = dataJSON["name"].stringValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
