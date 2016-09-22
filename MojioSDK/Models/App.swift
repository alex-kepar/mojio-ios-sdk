//
//  App.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-25.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

open class App: Object, Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var Description : String? = nil
    open var Downloads = RealmOptional<Int>()
    open var RedirectUris = List<StringObject>()
    open dynamic var AppImage : Image? = nil
    open var Tags = List<StringObject>()
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil

    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    open override static func primaryKey() -> String? {
        return "Id"
    }
    
    open func DownloadsAsIntNumber() -> NSNumber {
        return self.Downloads.value! as NSNumber
    }
    
    open func RedirectUrisArray() -> [StringObject] {
        return self.RedirectUris.toArray() as! [StringObject]
    }
    
    open func TagsArray() -> [StringObject] {
        return self.Tags.toArray() as! [StringObject]
    }

    open func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description" as NSCopying)
        }
        if self.RedirectUris.count > 0 {
            dictionary.setObject(self.RedirectUris.toArray(), forKey: "RedirectUris" as NSCopying)
        }
        
        if dictionary.count == 0 {
            return nil
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
        
        var redirectURIs = Array<String>()
        redirectURIs <- map["RedirectUris"]
        
        for uri in redirectURIs {
            let string = StringObject()
            string.value = uri
            
            self.Tags.append(string)
        }

        Name <- map["Name"]
        Description <- map["Description"]
        Downloads <- map["Downloads"]
        AppImage <- map["Image"]
        Id <- map["Id"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]

    }

}
