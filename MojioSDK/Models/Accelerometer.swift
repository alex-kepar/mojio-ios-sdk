//
//  Accelerometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class Accelerometer: Object, Mappable {
    
    open dynamic var X : ProperAcceleration? = nil
    open dynamic var Y : ProperAcceleration? = nil
    open dynamic var Z : ProperAcceleration? = nil
    open dynamic var Magnitude : ProperAcceleration? = nil
    open dynamic var SamplingInterval : TimePeriod? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        X <- map["X"];
        Y <- map["Y"];
        Z <- map["Z"];
        Magnitude <- map["Magnitude"];
        SamplingInterval <- map["SamplingInterval"];
    }

}
