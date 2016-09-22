//
//  TimePeriod.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class TimePeriodUnits : NSObject {
    open static let Ticks : String = "Ticks"
    open static let Milliseconds : String = "Milliseconds"
    open static let Seconds : String = "Seconds"
    open static let Minutes : String = "Minutes"
    open static let Hours : String = "Hours"
    open static let Days : String = "Days"
    open static let Weeks : String = "Weeks"
    open static let Months : String = "Months"
    open static let Years : String = "Years"
}

open class TimePeriod: Object, Mappable {
    
    open dynamic var BaseUnit : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // TimePeriodUnits
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
