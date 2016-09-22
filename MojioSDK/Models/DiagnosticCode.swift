//
//  DiagnosticCode.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class DiagnosticCode: Object, Mappable {
    
    open dynamic var Code : String? = nil
    open dynamic var Description : String? = nil
    open dynamic var Timestamp : String? = nil
    
    // RiskSeverity
    open dynamic var Severity : String? = nil
    open dynamic var Instructions : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        Code <- map["Code"];
        Description <- map["Description"];
        Timestamp <- map["Timestamp"];
        Severity <- map["Severity"];
        Instructions <- map["Instructions"];
    }

}
