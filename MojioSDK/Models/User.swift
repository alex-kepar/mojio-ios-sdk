//
//  User.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class User : Object, Mappable {
    
    open dynamic var FirstName : String? = nil
    open dynamic var LastName : String? = nil
    open dynamic var UserName : String? = nil
    open dynamic var Jurisdiction : String? = nil
    open var Emails = List<Email>()
    open var PhoneNumbers = List<PhoneNumber>()
    open dynamic var Img : Image? = nil
    open var Tags = List<StringObject>()
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    
    /* PUT & POST properties */
    open dynamic var email : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override static func primaryKey() -> String? {
        return "Id"
    }
    
    open func EmailsArray() -> [Email] {
        return self.Emails.toArray() as! [Email]
    }
    
    open func PhoneNumbersArray() -> [PhoneNumber] {
        return self.PhoneNumbers.toArray() as! [PhoneNumber]
    }
    
    open func TagsArray() -> [StringObject] {
        return self.Tags.toArray() as! [StringObject]
    }

    open func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.UserName != nil {
            dictionary.setObject(self.UserName!, forKey: "UserName" as NSCopying)
        }
        if self.email != nil {
            dictionary.setObject(self.email!, forKey: "Email" as NSCopying)
        }
        if self.FirstName != nil {
            dictionary.setObject(self.FirstName!, forKey: "FirstName" as NSCopying)
        }
        if self.LastName != nil {
            dictionary.setObject(self.LastName!, forKey: "LastName" as NSCopying)
        }
        if self.PhoneNumbers.count > 0 {
            dictionary.setObject(self.PhoneNumbers.toArray(), forKey: "PhoneNumbers" as NSCopying)
        }
        
        return dictionary
    }
    
    open func mapping(map: Map) {
        
        var emails = Array<Email>()
        emails <- map["Emails"]
        
        for email in emails {
            self.Emails.append(email)
        }
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }
        
        var phoneNumbers = Array<PhoneNumber>()
        phoneNumbers <- map["PhoneNumbers"]
        
        for phoneNumber in phoneNumbers {
            self.PhoneNumbers.append(phoneNumber)
        }
        
        self.FirstName <- map["FirstName"];
        self.LastName <- map["LastName"];
        self.UserName <- map["UserName"];
        self.Jurisdiction <- map["Jurisdiction"];
        Img <- map["Image"];
        self.Id <- map["Id"];
        self.CreatedOn <- map["CreatedOn"];
        self.LastModified <- map["LastModified"];
    }
}
