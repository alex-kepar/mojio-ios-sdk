//
//  Mojio.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class Mojio: Object, Mappable {
    open dynamic var Id : String? = nil
    open dynamic var Name : String? = nil
    open dynamic var IMEI : String? = nil
    open dynamic var LastContactTime : String? = nil
    open dynamic var GatewayTime : String? = nil
    open dynamic var VehicleId : String? = nil
    open dynamic var MojioLocation : Location? = nil
    open var Tags = List<StringObject>()
    open dynamic var Wifi : WifiRadio? = nil
    open dynamic var ConnectedState : BooleanState? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    open dynamic var Deleted : Bool = false

    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override static func primaryKey() -> String? {
        return "Id"
    }

    open func TagsArray() -> [StringObject] {
        return self.Tags.toArray() as! [StringObject]
    }
    
    open func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.IMEI != nil {
            dictionary.setObject(self.IMEI!, forKey: "IMEI" as NSCopying)
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

        Id <- map["Id"];
        Name <- map["Name"];
        IMEI <- map["IMEI"];
        LastContactTime <- map["LastContactTime"];
        Wifi <- map["WifiRadio"]
        GatewayTime <- map["GatewayTime"];
        VehicleId <- map["VehicleId"];
        MojioLocation <- map["Location"];
        ConnectedState <- map["ConnectedState"]
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
        Deleted <- map["Deleted"];
    }
}
