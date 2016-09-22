//
//  Vehicle.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class Vehicle: Object, Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var LicensePlate : String? = nil
    open dynamic var VIN : String? = nil
    open dynamic var DetectedVIN : String? = nil
    open dynamic var OverrideVIN : String? = nil    
    open dynamic var CurrentTrip : String? = nil
    open dynamic var MojioId : String? = nil
    open dynamic var VehicleImage : Image? = nil
    open dynamic var MilStatus : Bool = false
    open dynamic var LastContactTime : String? = nil
    open var DiagnosticCodes = List<DiagnosticCode>()
    open dynamic var VehicleAccelerometer : Accelerometer? = nil
    open dynamic var VehicleAcceleration : Acceleration? = nil
    open dynamic var Deceleration : Acceleration? = nil
    open dynamic var VehicleSpeed : Speed? = nil
    open dynamic var VehicleOdometer : Odometer? = nil
    open dynamic var VehicleRPM : RPM? = nil
    open dynamic var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    open dynamic var FuelEfficiencyCalculationMethod : String? = nil
    open dynamic var VehicleFuelLevel : FuelLevel? = nil
    
    // FuelType
    open dynamic var FuelType : String? = nil
    open dynamic var GatewayTime : String? = nil
    open dynamic var VehicleHarshEventState : HarshEvent? = nil
    open dynamic var VehicleIdleState : IdleState? = nil
    open dynamic var VehicleIgnitionState : BooleanState? = nil
    open dynamic var VehicleBattery : Battery? = nil
    open dynamic var VehicleHeading : Heading? = nil
    open dynamic var VehicleLocation : Location? = nil
    open dynamic var VehicleAccidentState : BooleanState? = nil
    open dynamic var VehicleVinDetails : VinDetails? = nil
    open dynamic var VehicleTowState : BooleanState? = nil
    open dynamic var VehicleParkedState : BooleanState? = nil
    open var Tags = List<StringObject>()
    open var OwnerGroups = List<StringObject>()
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    
    open dynamic var Deleted : Bool = false
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override static func primaryKey() -> String? {
        return "Id"
    }
    
    open func DiagnosticCodesArray() -> [DiagnosticCode] {
        return self.DiagnosticCodes.toArray() as! [DiagnosticCode]
    }
    
    open func TagsArray() -> [StringObject] {
        return self.Tags.toArray() as! [StringObject]
    }
    
    open func OwnerGroupsArray() -> [StringObject] {
        return self.OwnerGroups.toArray() as! [StringObject]
    }
    
    open func jsonVINDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()

        if self.VIN != nil {
            dictionary.setObject(self.VIN!, forKey: "VIN" as NSCopying)
        }

        if let detectedVin = self.DetectedVIN {
            dictionary["DetectedVIN"] = detectedVin
        }
        
        if let overrideVIN = self.OverrideVIN {
            dictionary["OverrideVIN"] = overrideVIN
        }
        return dictionary
    }
    
    open func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.LicensePlate != nil {
            dictionary.setObject(self.LicensePlate!, forKey: "LicensePlate" as NSCopying)
        }

        if self.VehicleOdometer != nil {
            let odo = self.VehicleOdometer!.jsonDict()
            dictionary.setObject(odo, forKey: "Odometer" as NSCopying)
        }
        
        return dictionary
    }
    
    open func mapping(map: Map) {
        
        var diagnosticCodes = Array<DiagnosticCode>()
        diagnosticCodes <- map ["DiagnosticCodes"]
        
        for diagnosticCode in diagnosticCodes {
            self.DiagnosticCodes.append(diagnosticCode)
        }
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }
        
        var ownerGroups = Array<String>()
        ownerGroups <- map["OwnerGroups"]
        
        for ownerGroup in ownerGroups {
            let string = StringObject()
            string.value = ownerGroup
            
            self.OwnerGroups.append(string)
        }
        

        Name <- map["Name"];
        LicensePlate <- map["LicensePlate"];
        VIN <- map["VIN"];
        DetectedVIN <- map["DetectedVIN"];
        OverrideVIN <- map["OverrideVIN"];
        CurrentTrip <- map["CurrentTrip"];
        MojioId <- map["MojioId"];
        VehicleImage <- map["Image"];
        MilStatus <- map["MilStatus"];
        LastContactTime <- map["LastContactTime"];
        VehicleAccelerometer <- map["Accelerometer"];
        VehicleAcceleration <- map["Acceleration"];
        Deceleration <- map["Deceleration"];
        VehicleSpeed <- map["Speed"];
        VehicleOdometer <- map["Odometer"];
        VehicleRPM <- map["RPM"];
        VehicleFuelEfficiency <- map["FuelEfficiency"];
        FuelEfficiencyCalculationMethod <- map["FuelEfficiencyCalculationMethod"];
        VehicleFuelLevel <- map["FuelLevel"];
        FuelType <- map["FuelType"];
        GatewayTime <- map["GatewayTime"];
        VehicleHarshEventState <- map["HarshEventState"];
        VehicleIdleState <- map["IdleState"];
        VehicleIgnitionState <- map["IgnitionState"];
        VehicleBattery <- map["Battery"];
        VehicleHeading <- map["Heading"];
        VehicleLocation <- map["Location"];
        VehicleAccidentState <- map["AccidentState"];
        VehicleVinDetails <- map["VinDetails"];
        VehicleTowState <- map["TowState"];
        VehicleParkedState <- map["ParkedState"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
        Deleted <- map["Deleted"];
    }
}
