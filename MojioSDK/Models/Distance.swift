//
//  Distance.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-28.
//
//

import UIKit
import ObjectMapper
import RealmSwift

open class Distance: Object, Mappable {
    
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
    
    open func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let baseUnit = self.BaseUnit {
            dictionary["BaseUnit"] = baseUnit as AnyObject?
            dictionary["BaseValue"] = self.BaseValue as AnyObject?
        }
        
        if let unit = self.Unit {
            dictionary["Unit"] = unit as AnyObject?
            dictionary["Value"] = self.Value as AnyObject?
        }

        return dictionary as NSDictionary
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
