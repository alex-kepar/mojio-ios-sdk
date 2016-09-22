//
//  VIN.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

open class Vin: Object, Mappable {
    
    open dynamic var VIN : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var Market : String? = nil
    open var Year : Int = 0
    open dynamic var Make : String? = nil
    open dynamic var Model : String? = nil
    open dynamic var VehicleType : String? = nil
    open dynamic var BodyType : String? = nil
    open dynamic var DriveType : String? = nil
    open dynamic var FuelTankSize : Float = 0
    open dynamic var EPAFuelEfficiency : Float = 0
    open dynamic var VehicleEngine : Engine? = nil
    open dynamic var VehicleTransmission : Transmission? = nil
    open var Warranties = List<Warranty>()
    open var Recalls = List<Recall>()
    open var ServiceBulletins = List<ServiceBulletin>()
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    open override static func primaryKey() -> String? {
        return "VIN"
    }
        
    open func WarrantiesArray() -> [Warranty] {
        return self.Warranties.toArray() as! [Warranty]
    }
    
    open func RecallsArray() -> [Recall] {
        return self.Recalls.toArray() as! [Recall]
    }
    
    open func ServiceBulletinsArray() -> [ServiceBulletin] {
        return self.ServiceBulletins.toArray() as! [ServiceBulletin]
    }
    
    open func mapping(map: Map) {
        
        var warranties = Array<Warranty>()
        warranties <- map["Warranties"]
        
        for warranty in warranties {
            self.Warranties.append(warranty)
        }
        
        var recalls = Array<Recall>()
        recalls <- map["Recalls"]
        
        for recall in recalls {
            self.Recalls.append(recall)
        }

        var serviceBulletins = Array<ServiceBulletin>()
        serviceBulletins <- map["ServiceBulletins"]
        
        for serviceBulletin in serviceBulletins {
            self.ServiceBulletins.append(serviceBulletin)
        }
        
        VIN <- map["VIN"]
        Timestamp <- map["Timestamp"]
        Market <- map["Market"]
        Year <- map["Year"]
        Make <- map["Make"]
        Model <- map["Model"]
        VehicleType <- map["VehicleType"]
        BodyType <- map["BodyType"]
        DriveType <- map["DriveType"]
        FuelTankSize <- map["FuelTankSize"]
        EPAFuelEfficiency <- map["EPAFuelEfficiency"]
        VehicleEngine <- map["Engine"]
        VehicleTransmission <- map["Transmission"]
        
    }    
}
