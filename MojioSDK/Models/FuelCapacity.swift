//
//  FuelCapacity.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class FuelCapacityUnits : NSObject {
    open static let Gallons : String = "Gallons"
    open static let Liters : String = "Liters"
}

open class FuelCapacity: Object, Mappable {
    
    open dynamic var BaseUnit : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // FuelCapacityUnits
    open dynamic var Unit : String? = nil
    open dynamic var Value : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }
    
}
