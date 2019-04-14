// Project:		Lab 11
// Class:		Contact
// Date:        4/13/17
// Author:      Dylan J. Hamilton
// Description: Is the Contact Class for the main program recently modified for error handling 


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
    private static var count:Int = 0
    
    // return the private count
    static func getCount()->Int
    {
        return count
    }
    
    // increment the private count
    static func incrementCount()
    {
        count += 1
    }
    
    // decrement the private count
    static func decrementCount()
    {
        count -= 1
    }

    // computed property to return all property values
    var info:String
    {
        get
        {
            return "\(name), \(email), \(phone), \(address.street), \(address.city), \(address.state), \(address.zip)"
        }
    }
    
    // description property returns string used in list
    override var description:String
    {
        return "\(name), \(email), \(phone), \(address), \(type)"
    }
    
    // initializer
    init(name:String, email:String, phone:String,
         street:String, city:String, state:String, zip:String, type:ContactType) throws
    {
        self.name = name
        self.email = email
        self.phone = phone
       try self.address = Address(street: street, city: city, state: state, zip: zip)
        self.type = type
        
        
        // increment the count
        Contact.count += 1
    }
    
    class Address : NSObject
    {
        // Stored properties
        var street1:String
        {
            set
            {
                validateStreet()
            }
            get
            {
                return street
            }
        }
        var street:String
        var city:String
        var state:String
        var zip:String
        
        
        // initializer
        init(street:String, city:String, state:String, zip:String) throws
        {
            self.street = street
            self.city = city
            self.state = state
            self.zip = zip
            
            // call method
            super.init()
            
            // call validate functions
            validateStreet()
            validateState()
            validateCity()
            
            // truncate street to 10 characters
            if street.characters.count > 10
            {
                // find the 10th index
                let index1 = street.index(street.startIndex, offsetBy: 10)
                // use the 10th index to substring the first 10 characters
                self.street = street.substring(to: index1)
            }
            else
            {
                self.street = street
            }
            
            // capitalizes the first character
              self.city = city.capitalized
            
            // checks for state exactly 2 characters and uppercase.
            self.state = state.uppercased()
            if state.characters.count > 2
            {
                //throws error
                throw ContactError.invalidState
            }
            
            // checks for zip exactly 5 digits
            if let range = zip.range(of: "^\\d{5}$", options: .regularExpression)
            {
               self.zip = zip.substring(with: range)
            }
            else
            {
                //throws error
                throw ContactError.invalidZip
            }
        }
        
        // the description properties returns all strings used in list
        override var description : String
        {
            return "\(street), \(city), \(state), \(zip)"
        }
        
        // function to validate street
        func validateStreet()
        {
            // truncates street to 10 characters
            if street.characters.count > 10
            {
                // find the 10th index
                let index1 = street.index(street.startIndex, offsetBy: 10)
                // use the 10th index to substring the first 10 characters
                street = street.substring(to: index1)
            }
        }
        
        // function to validate city
        func validateCity()
        {
            // capitalize the first character
            city = city.capitalized
        }
        
        // function to validate state
        func validateState()
        {
            // check for state exactly 2 characters and uppercase.
            self.state = state.uppercased()
            if state.characters.count > 2
            {
                state = "Error"
            }
        }
        
        // function to validate zip
        func validateZip()
        {
            // check for zip exactly 5 digits
            if let range = zip.range(of: "^\\d{5}$", options: .regularExpression)
            {
                zip = zip.substring(with: range)
            }
            else
            {
                zip = "Error"
            }
        }
    }
    
    enum ContactType:String
    {
        case BUSINESS, FAMILY, FRIEND
    }
    
}
