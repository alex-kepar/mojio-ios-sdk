//
//  Trip.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import RealmSwift

open class Trip: Object, Mappable {
    open dynamic var VehicleId : String? = nil
    open dynamic var Name : String? = nil
    open var Tags = List<StringObject>();
    open dynamic var MojioId : String? = nil
    open dynamic var Completed : Bool = false
    open dynamic var TripDuration : String? = nil
    open dynamic var TripDistance : Distance? = nil
    open dynamic var StartTimestamp : String? = nil
    open dynamic var EndTimestamp : String? = nil
    open dynamic var StartOdometer : Odometer? = nil
    open dynamic var EndOdometer : Odometer? = nil
    open dynamic var StartLocation : Location? = nil
    open dynamic var EndLocation : Location? = nil
    open dynamic var MaxSpeed : Speed? = nil
    open dynamic var MaxRPM : RPM? = nil
    open dynamic var MaxAcceleration : Acceleration? = nil
    open dynamic var MaxDeceleration : Acceleration? = nil
    open dynamic var TripFuelEfficiency : FuelEfficiency? = nil
    open dynamic var StartFuelLevel : FuelLevel? = nil
    open dynamic var EndFuelLevel : FuelLevel? = nil
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil

    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override static func primaryKey() -> String? {
        return "Id"
    }

    open func TagsArray() -> [StringObject] {
        return self.Tags.toArray() as! [StringObject]
    }
    
    open func json() -> String? {
        
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options:  JSONSerialization.WritingOptions.prettyPrinted)
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    open func mapping(map: Map) {
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }

        
        VehicleId <- map["VehicleId"];
        Name <- map["Name"];
        MojioId <- map["MojioId"];
        Completed <- map["Completed"];
        TripDuration <- map["Duration"];
        TripDistance <- map["Distance"]
        StartTimestamp <- map["StartTimestamp"];
        EndTimestamp <- map["EndTimestamp"];
        StartOdometer <- map["StartOdometer"];
        EndOdometer <- map["EndOdometer"];
        StartLocation <- map["StartLocation"];
        EndLocation <- map["EndLocation"];
        MaxSpeed <- map["MaxSpeed"];
        MaxRPM <- map["MaxRPM"];
        MaxAcceleration <- map["MaxAcceleration"];
        MaxDeceleration <- map["MaxDeceleration"];
        TripFuelEfficiency <- map["FuelEfficiency"];
        StartFuelLevel <- map["StartFuelLevel"];
        EndFuelLevel <- map["EndFuelLevel"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
        
    }
}
