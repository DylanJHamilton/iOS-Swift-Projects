// Project:		Lab 11
// Class:		Contact Family
// Date:        4/13/18
// Author:      Dylan J. Hamilton
// Description: Is the Contact Family Child Class that inherits from the Super Class (Contact) with addition of try method


import Foundation

class ContactFamily : Contact
{
    //declare variable relationship
    var relationship:String
    
    //add initializers
    init(name:String, email:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType, relationship:String) throws {
        
        //initialize the childs properties
        self.relationship = relationship
        
        //calls the super class Contact
       try super.init(name: name, email: email, phone: phone, street: street, city: city, state: state, zip: zip, type: type)
        
    }
    
    //execute string to return new variable
    override var description: String {
        
        return "\(super.description), \(relationship)"
        
    }
    
    
    
    
}
