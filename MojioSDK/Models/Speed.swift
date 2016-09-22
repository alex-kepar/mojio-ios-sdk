//
//  Speed.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class SpeedUnits : NSObject {
    open static let KilometersPerHour : String = "KilometersPerHour"
    open static let MilesPerHour : String = "MilesPerHour"
}

open class Speed: Object, Mappable {
    
    open dynamic var BaseUnit : String? = nil
    open dynamic var SpeedBandId : Int = 0
    open dynamic var SpeedBandDuration : TimePeriod? = nil
    open dynamic var Timestamp  : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // SpeedUnits
    open dynamic var Unit  : String? = nil
    open dynamic var Value : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Unit != nil {
            dictionary.setObject(self.Unit!, forKey: "Unit" as NSCopying)
        }
        
        dictionary.setObject(self.Value, forKey: "Value" as NSCopying)
        
        return dictionary
    }
    
    open func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        SpeedBandId <- map["SpeedBandId"];
        SpeedBandDuration <- map["SpeedBandDuration"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
