//
//  Battery.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class BatteryVoltageUnits : NSObject {
    open static let MilliVolts : String = "MilliVolts"
    open static let Volts : String = "Volts"
}

open class Battery : Object, Mappable {
    
    open dynamic var Connected : Bool = false
    
    // RiskSeverity
    open dynamic var RiskSeverity : String? = nil
    open dynamic var LowVoltageDuration : TimePeriod? = nil
    open dynamic var HighVoltageDuration : TimePeriod? = nil
    open dynamic var BaseUnit : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // BatteryVoltageUnits
    open dynamic var Unit : String? = nil
    open dynamic var Value : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        Connected <- map["Connected"];
        RiskSeverity <- map["RiskSeverity"];
        LowVoltageDuration <- map["LowVoltageDuration"];
        HighVoltageDuration <- map["HighVoltageDuration"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
