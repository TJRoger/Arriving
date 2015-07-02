//
//  AppDelegate.swift
//  Arriving
//
//  Created by Roger on 6/27/15.
//  Copyright (c) 2015 Roger. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain

//MARK: - AppDelegate, application life circle
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var destinations: [String:Destination] = Dictionary(minimumCapacity: 0)
    let locationManager: CLLocationManager = CLLocationManager()
    var destinationViewController: DestinationsViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        locationManager.delegate = self
        
        let currentAuthorizationStatus = CLLocationManager.authorizationStatus()
        if currentAuthorizationStatus == CLAuthorizationStatus.NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }else if currentAuthorizationStatus == CLAuthorizationStatus.Restricted || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied{
            
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        let nav = application.windows[0].rootViewController as! UINavigationController
        destinationViewController = nav.viewControllers[0] as! DestinationsViewController
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: - Add destination entry
    func addDestination(destination: Destination){
        destinations.updateValue(destination, forKey: destination.region.identifier)
        locationManager.startMonitoringForRegion(destination.region)
        
        destinationViewController.destinations.append(destination)
        destinationViewController.saveDestination()
        destinationViewController.tableView.reloadData()
    }
    
    //MARK: - Alarm Entry
    func launchAlarm(destination: Destination!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alarmVC = storyboard.instantiateViewControllerWithIdentifier("Alarm") as! AlarmViewController
        alarmVC.destination = destination
        //embed alarmViewController in a navigationController
        let nav = UINavigationController(rootViewController: alarmVC)
        destinationViewController.presentViewController(nav, animated: true, completion: nil)
    }
    
    func destinationForRegionIdentifier(identifier: String!) -> Destination? {
        if let destination = destinations[identifier] {
            return destination
        }else {
            return nil
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("Entered Region: " + region.identifier)
        if let destination = destinationForRegionIdentifier(region.identifier) {
            launchAlarm(destination)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("Exited Region: " + region.identifier)
        locationManager.stopMonitoringForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        println("Error monitoring regions " + error.description)
        let currentAuthorizationStatus = CLLocationManager.authorizationStatus()
        if currentAuthorizationStatus == CLAuthorizationStatus.Denied || currentAuthorizationStatus == CLAuthorizationStatus.NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }

}

