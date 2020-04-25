//
//  User.swift
//  Demo
//
//  Created by Naina Ghormare on 4/21/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class User:NSObject {
    public var token            : String?
    public var role             : String?
    public var user_id          : String?
    public var name             : String?
    public var country          : String?
    public var mobile_no        : String?
    public var email            : String?
    public var second_mobile_no : String?
    public var address          : String?
    public var password         : String?
    public var confirmPassword  : String?
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    
    public override init() {
        super.init()
    }
    public class func modelsFromDictionaryArray(array: Array<Dictionary<String,Any>>) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            if let model = User(dictionary: item) {
                models.append(model)
            }
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let User = User(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: User Instance.
     */
    required public init?(dictionary: Dictionary<String,Any>) {
        token            = dictionary["token"]              as? String ?? ""
        role             = dictionary["role"]               as? String ?? ""
        user_id          = dictionary["user_id"]            as? String ?? ""
        name             = dictionary["name"]               as? String ?? ""
        country          = dictionary["country"]            as? String ?? ""
        mobile_no        = dictionary["mobile_no"]          as? String ?? ""
        email            = dictionary["email"]              as? String ?? ""
        second_mobile_no = dictionary["second_mobile_no"]   as? String ?? ""
        address          = dictionary["address"]            as? String ?? ""
        password         = dictionary["password"]           as? String ?? ""
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.token, forKey: "token")
        dictionary.setValue(self.role, forKey: "role")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.country, forKey: "country")
        dictionary.setValue(self.mobile_no, forKey: "mobile_no")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.second_mobile_no, forKey: "second_mobile_no")
        dictionary.setValue(self.address, forKey: "address")
        dictionary.setValue(self.password, forKey: "password")
        return dictionary
    }
    
}
