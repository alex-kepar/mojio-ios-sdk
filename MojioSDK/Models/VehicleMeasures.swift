//
//  VehicleMeasures.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-03-04.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class VehicleMeasures: Object, Mappable {
    
    open dynamic var VehicleAcceleration : Acceleration? = nil
    open dynamic var VehicleAccelerometer : Accelerometer? = nil
    open dynamic var AccidentState : BooleanState? = nil
    open dynamic var VehicleBattery : Battery? = nil
    open dynamic var CurrentTrip : String? = nil
    open dynamic var Deceleration : Acceleration? = nil
    open var DiagnosticCodes = List<DiagnosticCode>()
    open dynamic var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    open dynamic var FuelEfficiencyCalculationMethod : String? = nil// ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    open dynamic var VehicleFuelLevel : FuelLevel? = nil
    
    // FuelType
    open dynamic var FuelType : String? = nil
    open dynamic var GatewayTime : String? = nil
    open dynamic var HarshEventState : HarshEvent? = nil
    open dynamic var VehicleHeading : Heading? = nil
    open dynamic var VehicleIdleState : IdleState? = nil
    open dynamic var IgnitionState : BooleanState? = nil
    open dynamic var VehicleLocation : Location? = nil
    open var MilStatus = RealmOptional<Bool>()
    open dynamic var MojioId : String? = nil
    open dynamic var ParkedState : BooleanState? = nil
    open dynamic var VehicleRPM : RPM? = nil
    open dynamic var VehicleSpeed : Speed? = nil
    open dynamic var TowState : BooleanState? = nil
    open dynamic var VIN : String? = nil
    open dynamic var VehicleVinDetails : VinDetails? = nil
    open dynamic var VirtualOdometer : Odometer? = nil
    open dynamic var VehicleOdometer : Odometer? = nil
    open dynamic var Time : String? = nil
    open dynamic var DisturbanceState : BooleanState? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }

    open func mapping(map: Map) {
        var diagnosticCodes = Array<DiagnosticCode>()
        diagnosticCodes <- map ["DiagnosticCodes"]
        
        for diagnosticCode in diagnosticCodes {
            self.DiagnosticCodes.append(diagnosticCode)
        }
        
        VehicleAcceleration <- map["Acceleration"]
        VehicleAccelerometer <- map["Accelerometer"]
        AccidentState <- map["AccidentState"]
        VehicleBattery <- map["Battery"]
        CurrentTrip <- map["CurrentTrip"]
        Deceleration <- map["Deceleration"]
        VehicleFuelEfficiency <- map["FuelEfficiency"]
        FuelEfficiencyCalculationMethod <- map["FuelEfficiencyCalculationMethod"]
        VehicleFuelLevel <- map["FuelLevel"]
        FuelType <- map["FuelType"]
        GatewayTime <- map["GatewayTime"]
        HarshEventState <- map["HarshEventState"]
        VehicleHeading <- map["Heading"]
        VehicleIdleState <- map["IdleState"]
        IgnitionState <- map["IgnitionState"]
        VehicleLocation <- map["Location"]
        MilStatus <- map["MilStatus"]
        MojioId <- map["MojioId"]
        ParkedState <- map["ParkedState"]
        VehicleRPM <- map["RPM"]
        VehicleSpeed <- map["Speed"]
        TowState <- map["TowState"]
        VIN <- map["VIN"]
        VehicleVinDetails <- map["VinDetails"]
        VirtualOdometer <- map["VirtualOdometer"]
        VehicleOdometer <- map["Odometer"]
        Time <- map["Time"]
    }
}
