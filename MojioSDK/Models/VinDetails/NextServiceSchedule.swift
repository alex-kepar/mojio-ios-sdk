//
//  NextServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class NextServiceSchedule: Object, Mappable {

    open dynamic var TimeStamp : String? = nil
    open dynamic var Odometer : Float = 0
    open var AgeInMonths = RealmOptional<Int>()
    open dynamic var TimeUnits : String? = nil
    open dynamic var TimeValue : Float = 0
    open dynamic var DistanceUnits : String? = nil
    open dynamic var DistanceValue : Float = 0
    open var Services = List<PlatformServiceSchedule>()
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    open func AgeInMonthsAsIntNumber() -> NSNumber? {
        if let value = self.AgeInMonths.value {
            return NSNumber(value: value)
        }
        
        return NSNumber(value: 0)
    }
    
    open func ServicesArray() -> [PlatformServiceSchedule] {
        return self.Services.toArray() as! [PlatformServiceSchedule]
    }
    
    open func mapping(map: Map) {
        
        var services = Array<PlatformServiceSchedule>()
        services <- map["Items"]
        
        for service in services {
            self.Services.append(service)
        }
        
        TimeStamp <- map["TimeStamp"]
        Odometer <- map["Odometer"]
        AgeInMonths <- map["AgeInMonths"]
        TimeUnits <- map["TimeUnits"]
        TimeValue <- map["TimeValue"]
        DistanceUnits <- map["DistanceUnits"]
        DistanceValue <- map["DistanceValue"]
    }
}
