// Project:		Lab 11
// Class:		ViewController
// Date:        4/13/18
// Author:      Dylan Hamilton
// Description: Modify Lab10 by adding a Delete Button to the project and sorting by new array!


import Cocoa

class ViewController: NSViewController, NSTableViewDataSource,NSTableViewDelegate
{
    @IBOutlet weak var tfName: NSTextField!
    @IBOutlet weak var tfPhone: NSTextField!
    @IBOutlet weak var tfEmail: NSTextField!
    @IBOutlet weak var tfStreet: NSTextField!
    @IBOutlet weak var tfCity: NSTextField!
    @IBOutlet weak var tfState: NSTextField!
    @IBOutlet weak var tfZip: NSTextField!
    @IBOutlet weak var lblCount: NSTextField!
    @IBOutlet weak var tvContacts: NSTableView!
    @IBOutlet weak var puType: NSPopUpButton!
    @IBOutlet weak var tfDependent: NSTextField!
    @IBOutlet weak var lblDependent: NSTextField!
    
   
    //Gives functionality for Label to change when selecting in Button
    @IBAction func puAction(_ sender: NSPopUpButton) {
        switch(puType.indexOfSelectedItem){
            
        case 0:
            lblDependent.stringValue = "Company"
        case 1:
            lblDependent.stringValue = "Relationship"
        case 2:
            lblDependent.stringValue = "Year Met"
        default:
            lblDependent.stringValue = "Company"
        }
        //clear the text field of old data
        tfDependent.stringValue = ""
    }
    
    
    // array to hold Strings in tableView
    var contacts:[String] = []
    
    
    //array to hold the contact objects
   var contactObjects:[Contact] = []
    
    
    //sort action for lab 8 
    @IBAction func Sort(_ sender: Any) {
    //sort the array 
        contactObjects.sort(by:
        {
        contact1, contact2 in
        contact1.name < contact2.name
        }
        )
        
        //rebuilds the array of strings for the table 
        //and removes all of the old unsorted strings
        contacts.removeAll()
        for c1 in contactObjects
        {
            contacts.append(c1.description)
        }
        
        
        //updates the tableView
        tvContacts.reloadData()
        
    }
    
    
    @IBAction func btnExit(_ sender: NSButton)
    {
        NSApplication.shared().terminate(self)
    }
    
    @IBAction func btnDelete(_ sender: NSButton) {
        
        // get the selected row
        let selectedRow = tvContacts.selectedRow
        
        // if nothing is selected display error message, -1 if no row is selected
        if selectedRow < 0
        {
            // create an Alert to display error
            let myPopup: NSAlert = NSAlert()
            // set the title
            myPopup.messageText = "Deletion Error"
            // set the message
            myPopup.informativeText = "Nothing Selected in Table"
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            myPopup.runModal()
        }
        else
        {
            // get the selected string in the table using table selected row and the employees array
            let selectedString = contacts[selectedRow]
            
            // separate the selected string into individual strings using , as delimiter
            let selectedArray = selectedString.components(separatedBy: ",")
            
            // get the name which is in position 0
            let name = selectedArray[0]
            print("name: \(name)")
            
            // remove the employee from the array employeeObjects
            contactObjects.remove(at: selectedRow)
            
            // remove the string from the array employees
            contacts.remove(at: selectedRow)
            
            // decrement the count
            Contact.decrementCount()
            
            // get the current count from the Contact class and display it in the label
            lblCount.stringValue = "Count \(Contact.getCount())"
            
            // reload the table
            tvContacts.reloadData()
        }
        
    }
    
    
    
    @IBAction func btnAdd(_ sender: NSButton)
    {
        
        var conObj:Contact? = nil
        

        
        // switch statement to determine which type is selected with do and try for error handling
        
        do
        {
            switch(puType.indexOfSelectedItem)
            {
            case 0:
                //Adds Business Object
                try conObj = ContactBusiness(name: tfName.stringValue, email: tfEmail.stringValue, phone: tfPhone.stringValue, street: tfStreet.stringValue, city: tfCity.stringValue, state: tfState.stringValue, zip: tfZip.stringValue, type: Contact.ContactType.BUSINESS,  company: tfDependent.stringValue)
            //Adds Family Object
            case 1:
                try conObj = ContactFamily(name: tfName.stringValue, email: tfEmail.stringValue, phone: tfPhone.stringValue, street: tfStreet.stringValue, city: tfCity.stringValue, state: tfState.stringValue, zip: tfZip.stringValue, type: Contact.ContactType.FAMILY,  relationship: tfDependent.stringValue)
            //Adds Friend Object
            case 2:
                let yearMet = Int(tfDependent.stringValue) ?? 0
                try conObj = ContactFriend(name: tfName.stringValue, email: tfEmail.stringValue, phone: tfPhone.stringValue, street: tfStreet.stringValue, city: tfCity.stringValue, state:tfState.stringValue, zip: tfZip.stringValue, type: Contact.ContactType.FRIEND, yearMet: yearMet)
                
            //default list item
            default:
                conObj = nil
            }
            
            //add contact object to array
            contactObjects.append(conObj!)
            
            // get the string value from contact
            lblCount.stringValue = "Count \(Contact.getCount())"

            
            // add the student to the array
            contacts.append((conObj?.description)!)
            
            // update the tableView
            tvContacts.reloadData()
        }
            
            //run catch error for invalid state
        catch ContactError.invalidState
        {
            
            let myPopup : NSAlert = NSAlert()
            
            myPopup.messageText = "Contact Creation Error"
            myPopup.informativeText = "Invalid State"
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            
            myPopup.runModal()
            
        }
            //run catch error for invalid zip code
        catch ContactError.invalidZip
        {
            
            let myPopup: NSAlert = NSAlert()
            myPopup.messageText = "Contact Creation Error"
            myPopup.informativeText = "Invalid Zip. Please Enter Five Digits."
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            myPopup.runModal()
        }
            //final catch method to catch both catch methods 
        catch
        {
            
        }
    }
   
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Tells the TableView what class is handling the source and delegate
        tvContacts.dataSource = self
        tvContacts.delegate = self
    }

    override var representedObject: Any?
    {
        didSet
        {
        // Update the view, if already loaded.
        }
    }
    
    
    // TableView
    // change content mode on tableView to cell based
    // set columns to 1
    // uncheck headers
    // set the cell identifier: select the table column, identity inspector,change identity property
    
    // returns the string for the row and column
    func tableView(_ tableView: NSTableView,
                   objectValueFor tableColumn: NSTableColumn?,
                   row: Int) -> Any?
    {
        
//        print("column: \(tableColumn?.identifier)row: \(row)")
        return contacts[row]
    }
    
    // returns the number of rows in the tableView
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return contacts.count
    }
    
    // called when the user selects an item in the table
    // you should always get the data from the tables data source
    func tableViewSelectionDidChange(_ notification: Notification)
    {
        // get the selected row
        let row = tvContacts.selectedRow
        
        
        // get the string from the array at row
        // user can select nothing in the list which returns -1
        if row >= 0 && row < contacts.count
        {
            print("Selected: \(contacts[row])")
        }
    }
    
}

