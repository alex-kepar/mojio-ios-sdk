//
//  PhoneNumber.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class PhoneNumber : Object, Mappable {

    open dynamic var PhoneNumber : String? = nil
    open dynamic var Verified : Bool = false
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    open func mapping(map: Map) {
        PhoneNumber <- map["PhoneNumber"];
        Verified <- map["Verified"];
    }
}
