// Project:		Lab 11
// Class:		Contact Friend
// Date:        4/13/18
// Author:      Dylan J. Hamilton
// Description: Is the Contact Friend Child Class that inherits from the Super Class (Contact) with addition of try


import Foundation

class ContactFriend : Contact
{
    //declare variable yearMet
    var yearMet:Int
    
    //add initializers
     init(name:String, email:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType, yearMet:Int) throws {
        
        //initialize the childs properties
        self.yearMet = yearMet
        
        //calls the super class Contact
       try super.init(name: name, email: email, phone: phone, street: street, city: city, state: state, zip: zip, type: type)
        
    }
    
    //execute string to return new variable
    override var description: String {
    
        return "\(super.description), \(yearMet)"
    
    }
    
    
    
    
}
