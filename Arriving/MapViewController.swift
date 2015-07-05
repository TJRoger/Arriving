//
//  MapViewController.swift
//  Arriving
//
//  Created by Roger on 6/27/15.
//  Copyright (c) 2015 Roger. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

//protocol MapViewControllerDelegate {
//    func returnedRegion(region: CLCircularRegion)
//}

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var targetView: UIView!
//    var delegate: MapViewControllerDelegate! = nil
    var region: CLCircularRegion!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectDestination(sender: UIBarButtonItem) {
//        if delegate != nil {
        let center = mapView.centerCoordinate
        let targetViewRegion = mapView!.convertRect(targetView.bounds, toRegionFromView: targetView)
        
        let radius = targetViewRegion.span.latitudeDelta * 110 * 1000
        
        //create a unique UUID
        let uuid = NSUUID().UUIDString
        region = CLCircularRegion(center: center, radius: radius, identifier: uuid)
//            self.delegate!.returnedRegion(region)
        performSegueWithIdentifier("Unwind MapView", sender: self)
//        }
    }

//    @IBAction func unwindToDestinationCreateMenu(sender: UIStoryboardSegue){
//        
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var dst = segue.destinationViewController as? UIViewController
        if let navCon = dst as? UINavigationController {
            dst = navCon.visibleViewController
        }
        if let hvc = dst as? DestinationCreateViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "Unwind MapView":
                    hvc.region = region
                default:
                    return
                }
                
            }
        }

    }
    

}
