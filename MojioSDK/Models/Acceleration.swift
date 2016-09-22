//
//  Acceleration.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class AccelerationUnits : NSObject {
    
    // Meters per second per second
    open static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    
    // KiloMeters per hour per second
    open static let KilometersPerHourPerSecond : String  = "KilometersPerHourPerSecond"
    
    // Miles per hour per second
    open static let MilesPerHourPerSecond : String = "MilesPerHourPerSecond"
}

open class Acceleration: Object, Mappable {

    open dynamic var BaseUnit : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // AccelerationUnits
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
