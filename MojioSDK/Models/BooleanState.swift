//
//  BooleanState.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class BooleanState: Object, Mappable {
    
    open dynamic var Timestamp : String? = nil
    open dynamic var Value : Bool = false
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
    }
    
}
