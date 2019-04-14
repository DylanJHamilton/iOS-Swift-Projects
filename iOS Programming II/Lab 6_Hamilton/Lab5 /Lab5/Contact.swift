// Project: Lab 6
// Class: Contact.swift
// Author: Dylan J. Hamilton
// Description: Class for the contacts and the address with the inclusion of an enumerator. 


import Foundation
class Contact : NSObject
{
    // Stored properties
    var name:String
    var email:String
    var phone:String
    var address:Address
    var type:ContactType
    
    // type stored property
    static var count:Int = 0 //how to make private?
    
    // computed property to return all property values
    var info:String
    {
        get
        {
            return "\(name), \(email), \(phone), \(address.street), \(address.city), \(address.state), \(address.zip)"
        }
    }
    
    // description property returns list strings
    override var description:String
    {
        return "\(name), \(email), \(phone), \(address), \(type)"
    }
    
    //  the initializer
    init(name:String, email:String, phone:String,
         street:String, city:String, state:String, zip:String, type:ContactType)
    {
        self.name = name
        self.email = email
        self.phone = phone
        self.address = Address(street: street, city: city, state: state, zip: zip)
        self.type = type
        
        // increments the count
        Contact.count += 1
    }
    
    class Address : NSObject
    {
        // Stored properties of data
        var street:String
        var city:String
        var state:String
        var zip:String
        
        // description property returns strings
        override var description : String
        {
            return "\(street), \(city), \(state), \(zip)"
        }
        
        // initializer
        init(street:String, city:String, state:String, zip:String)
        {
            self.street = street
            self.city = city
            self.state = state
            self.zip = zip
        }
    }
    
    enum ContactType:String
    {
        case BUSINESS, FAMILY, FRIEND
    }
    
}
