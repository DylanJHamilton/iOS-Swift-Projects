// Project:		Lab 11
// Class:		Contact Business
// Date:        4/13/18
// Author:      Dylan J. Hamilton
// Description: This is the enumerator that calls the errors for the mainframe GUI
import Foundation

//Enumerator Contact Error Calls both case for Invalid State and Invalid ZIP
enum ContactError : Error{
    
    case invalidState
    case invalidZip
    
}
