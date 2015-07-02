//
//  AlarmViewController.swift
//  Arriving
//
//  Created by Roger on 6/27/15.
//  Copyright (c) 2015 Roger. All rights reserved.
//

import UIKit
import MediaPlayer

class AlarmViewController: UIViewController {

    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
    var destination: Destination!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = destination.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        playMedia(destination.media)
    }
    
    func playMedia(media: MPMediaItem!) {
        let array = [media]
        let collection = MPMediaItemCollection(items: array)
        
        musicPlayer.setQueueWithItemCollection(collection)
        musicPlayer.play()
        destination.arrived = true
    }
    
    @IBAction func stopPlayingMedia(sender: AnyObject) {
        musicPlayer.stop()
        navigationController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
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
