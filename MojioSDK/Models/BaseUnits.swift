//
//  BaseUnits.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 4/18/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation

open class RiskSeverity : NSObject {
    open static let Unknown : String = "Unknown"
    open static let Low : String = "Low"
    open static let Medium : String = "Medium"
    open static let High : String = "High"
    open static let None : String = "None"
}

open class DistanceUnits : NSObject {
    open static let Meters : String = "Meters"
    open static let Miles : String = "Miles"
    open static let Kilometers : String = "Kilometers"
    open static let NauticalMiles : String = "NauticalMiles"
    open static let CentiMeter : String = "CentiMeter"
    open static let MilliMeter : String = "MilliMeter"
}

open class FuelType : NSObject {
    open static let Query : String = "Query"
    open static let Gasoline : String = "Gasoline"
    open static let Diesel : String = "Diesel"
    open static let Electric : String = "Electric"
}

open class FuelEfficiencyCalculationMethod : NSObject {
    open static let Query : String = "Query"
    open static let EngineFuelRate : String = "EngineFuelRate"
    open static let MassAirFlow : String = "MassAirFlow"
    open static let Calculated : String = "Calculated"
    open static let None : String = "None"
}
