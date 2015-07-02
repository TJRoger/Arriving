//
//  Destination.swift
//  Arriving
//
//  Created by Roger on 6/27/15.
//  Copyright (c) 2015 Roger. All rights reserved.
//

import UIKit
import CoreLocation
import MediaPlayer

class Destination: NSObject, NSCoding {
    var title: String
    var region: CLCircularRegion
    var media: MPMediaItem
    var arrived: Bool = false
    init(title: String, region: CLCircularRegion, media: MPMediaItem){
        self.title = title
        self.region = region
        self.media = media
    }
    
    //MARK: - NSCoding Protocol
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.region = aDecoder.decodeObjectForKey("region") as! CLCircularRegion
        self.media = aDecoder.decodeObjectForKey("media") as! MPMediaItem
        self.arrived = aDecoder.decodeBoolForKey("arrived")
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(region, forKey: "region")
        aCoder.encodeObject(media, forKey: "media")
        aCoder.encodeBool(arrived, forKey: "arrived")
    }
    
}
