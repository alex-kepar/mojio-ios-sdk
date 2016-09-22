//
//  FuelEfficiency.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class FuelEfficiencyUnits : NSObject {
    open static let MilesPerGallon : String = "MilesPerGallon"
    open static let KilometerPerLiter : String = "KilometerPerLiter"
    open static let LitersPerHundredKilometers : String = "LitersPerHundredKilometers"
}

open class FuelEfficiency: Object, Mappable {
    
    open dynamic var BaseUnit : String? = nil
    open dynamic var Statistics : MeasurementStatistics? = nil
    open dynamic var BenchmarkTime : String? = nil
    open dynamic var BenchmarkStatistics : MeasurementStatistics? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // FuelEfficiencyUnits
    open dynamic var Unit  : String? = nil
    open dynamic var Value : Float = 0

    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Statistics <- map["Statistics"];
        BenchmarkTime <- map["BenchmarkTime"];
        BenchmarkStatistics <- map["BenchmarkStatistics"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
