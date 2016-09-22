//
//  ProperAcceleration.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class AccelerometerUnits : NSObject {
    open static let MilliGUnits : String = "MilliGUnits"
    open static let NewtonsPerKilogram : String = "NewtonsPerKilogram"
    open static let XirgoUnit : String = "XirgoUnit"
    open static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    open static let CentimetersPerSecondPerSecond : String = "CentimetersPerSecondPerSecond"
    open static let GUnits : String = "GUnits"
}

open class ProperAcceleration: Object, Mappable {

    open dynamic var BaseUnit : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // AccelerometerUnits
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
