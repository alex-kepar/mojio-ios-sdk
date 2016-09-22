//
//  IdleState.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 9/21/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class IdleState: Object, Mappable {
    
    open dynamic var Timestamp : String? = nil
    open dynamic var Value : Bool = false
    open dynamic var StartTime : String? = nil
    open dynamic var Duration : TimePeriod? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
        StartTime <- map["StartTime"];
        Duration <- map["Duration"];
    }
    
}

