// Project:		Lab6
// Class:       ViewController
// Date:        2/17/18
// Author:      Dylan J. Hamilton
// Description: Main Class


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
    
    // array to hold Strings in tableView
    var contacts:[String] = []
    
    @IBAction func btnExit(_ sender: NSButton)
    {
        NSApplication.shared().terminate(self)
    }
    
    @IBAction func btnAdd(_ sender: NSButton)
    {
        // declare a ContactType variable
        var inputType:Contact.ContactType = Contact.ContactType.BUSINESS
        
        // switch statement to determine which type is selected
        // indexes start at 0
        switch(puType.indexOfSelectedItem)
        {
        case 0:
            inputType = Contact.ContactType.BUSINESS
        case 1:
            inputType = Contact.ContactType.FAMILY
        case 2:
            inputType = Contact.ContactType.FRIEND
        default:
            inputType = Contact.ContactType.BUSINESS
        }
        
        // creates the Contact object
        let conObj = Contact(name: tfName.stringValue, email: tfEmail.stringValue, phone: tfPhone.stringValue,
                             street: tfStreet.stringValue, city: tfCity.stringValue, state: tfState.stringValue, zip: tfZip.stringValue,
                             type: inputType)
        
        // get the current count from the Contact class and display it in the label
        lblCount.stringValue = "Count \(Contact.count)"
        
        // ads sthe contact to the array
        contacts.append(conObj.description)
        
        // updatesthe tableView
        tvContacts.reloadData()
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        
        tvContacts.dataSource = self
        tvContacts.delegate = self
    }
    
    override var representedObject: Any?
        {
        didSet
        {
            // Updates the view, if already loaded.
        }
    }
    
    
    // TableView
    // returns the string for the row
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
    
    // when the user selects an item in the table
    func tableViewSelectionDidChange(_ notification: Notification)
    {
        // get the selected row
        let row = tvContacts.selectedRow
        
        
        // get the string from the array row
        
        if row >= 0 && row < contacts.count
        {
            print("Selected: \(contacts[row])")
        }
    }
    
}

