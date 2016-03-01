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
    
    
    var dataJSON : JSON!

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
        skills?.text = dataJSON["skills"].stringValue
        mapView.delegate = self
        let latitude = dataJSON["latitude"].doubleValue
        let longitude = dataJSON["longitude"].doubleValue
        print(latitude,longitude)
        let center = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)

        
        //        self.photo.image = UIImage(data: NSData(contentsOfFile: dataJSON["picture"].stringValue)!)

    }
    
    func populate() {
        self.navigationItem.title = dataJSON["name"].stringValue
        
//        company.text = dataJSON["company"].stringValue
//        phone.text = dataJSON["phone"].stringValue
//        email.text = dataJSON["email"].stringValue
        //skills.text = dataJSON["skills"].stringValue
    
//
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
