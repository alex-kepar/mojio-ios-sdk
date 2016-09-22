//
//  Odometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class Odometer: Object, Mappable {
    
    open dynamic var RolloverValue : Float = 0
    open dynamic var BaseUnit : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // DistanceUnits
    open dynamic var Unit : String? = nil
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
        RolloverValue <- map["RolloverValue"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }
}
