//
//  DestinationCreateViewController.swift
//  Arriving
//
//  Created by Roger on 6/27/15.
//  Copyright (c) 2015 Roger. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreLocation

class DestinationCreateViewController: UITableViewController, MPMediaPickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var mapCell: UITableViewCell!
    @IBOutlet weak var mapLabel: UILabel!
    
    @IBOutlet weak var mediaCell: UITableViewCell!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaLabel: UILabel!
    
    var mediaItem: MPMediaItem?
    var region: CLCircularRegion?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        navigationController?.presentingViewController?.dismissViewControllerAnimated(true){
            
        }
        
    }
    
    @IBAction func done(sender: AnyObject) {
        if (region == nil || mediaItem == nil || titleTextField.text.isEmpty){
            var alert = UIAlertView(title: "Information missing", message: "Please choose all of the three kind of information for your destination", delegate: nil, cancelButtonTitle: "Get it")
            alert.show()
            return
        }
        var destination = Destination(title: titleTextField.text, region: region!, media: mediaItem!)
        navigationController!.presentingViewController!.dismissViewControllerAnimated(true){
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.addDestination(destination)
        }
    }
    
    //MARK: - view life circle
    override func viewDidAppear(animated: Bool) {
        if titleTextField.text.isEmpty {
            titleTextField.becomeFirstResponder()
        }
    }
    
    
    //MARK: - tableviewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell == mediaCell {
            let mediaPicker = MPMediaPickerController(mediaTypes: .Music)
            mediaPicker.delegate = self
            mediaPicker.prompt = "Select your favorite song!"
            mediaPicker.allowsPickingMultipleItems = false
            presentViewController(mediaPicker, animated: true){
                
            }
        }
    }
    
    //MARK: - MapViewControllerDelegate
    func returnedRegion(region: CLCircularRegion) {
//        self.region = region
//        mapLabel.text = "Destination Region Selected"
//        self.navigationController!.popViewControllerAnimated(true)
    }
    
    //MARK: - MPMediaPickerControllerDelegate
    func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        var mediaItem = mediaItemCollection.items[0] as! MPMediaItem
        if mediaItem.artwork != nil {
            mediaImageView!.image = mediaItem.artwork.imageWithSize(mediaCell!.contentView.bounds.size)
            mediaImageView!.hidden = false
        }
        self.mediaItem = mediaItem
        self.dismissViewControllerAnimated(true){
            
        }
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
        self.dismissViewControllerAnimated(true){
            
        }
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    @IBAction func getRegionFromMap(sender: UIStoryboardSegue){
        if self.region != nil {
            self.mapLabel.text = "Destination Region Selected"
            
        }
    }
    
    //MARK: - Prepare For Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //unwrap the Destination ViewController if it's embled in navigation controller
//        var dst = segue.destinationViewController as? UIViewController
//        if let navCon = dst as? UINavigationController {
//            dst = navCon.visibleViewController
//        }
//        if let hvc = dst as? MapViewController {
//            if let identifier = segue.identifier {
//                switch identifier {
//                case "Show Map":
//                    hvc.delegate = self;
//                    
//                default:
//                    return
//                }
//            }
//        }
//
    }
}
