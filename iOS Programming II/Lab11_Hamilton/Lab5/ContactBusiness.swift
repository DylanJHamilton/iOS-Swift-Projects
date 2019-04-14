// Project:		Lab 11
// Class:		Contact Business
// Date:        4/13/18
// Author:      Dylan J. Hamilton
// Description: Is the Contact BusinesChild Class that inherits from the Super Class (Contact) with addition of try method 


import Foundation

class ContactBusiness : Contact
{
    //declare variable company
    var company:String
    
    //add initializers
    init(name:String, email:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType, company:String) throws {
        
        //initialize the childs properties
        self.company = company
        
        //calls the super class Contact
       try super.init(name: name, email: email, phone: phone, street: street, city: city, state: state, zip: zip, type: type)
        
    }
    
    
    //execute string to return variable
    override var description: String {
        
        return "\(super.description), \(company)"
        
    }
    
    
    
    
}
