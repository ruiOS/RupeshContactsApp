//
//  CDContact+CoreDataProperties.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//
//

import Foundation
import CoreData

extension CDContact: NSManagedObjectEntityProtocol {

    /// entity name of the contact
    static var entityName: String {
        "CDContact"
    }

    ///NSFetchRequest method used to fetch contacts
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContact> {
        return NSFetchRequest<CDContact>(entityName: "CDContact")
    }

    ///contactNumber of contact
    @NSManaged public var contactNumber: String?
    ///firstName of contact
    @NSManaged public var firstName: String?
    ///contactPic of contact
    @NSManaged public var contactPic: Data?
    ///id of contact
    @NSManaged public var id: UUID?
    ///lastName of contact
    @NSManaged public var lastName: String?
    ///middleName of contact
    @NSManaged public var middleName: String?

    ///method returns contact value of cdContact
    func convertToContact() -> Contact{
        Contact(contactNumber: self.contactNumber, contactPic: self.contactPic, firstName: self.firstName, lastName: self.lastName, middleName: self.middleName, id: self.id!)
    }

    /// method binds contact value to self
    /// - Parameter contact: contact to be binded to self
    func bind(contact: Contact){
        self.contactNumber = contact.contactNumber
        self.contactPic = contact.contactPic
        self.firstName = contact.firstName
        self.id = contact.id
        self.lastName = contact.lastName
        self.middleName = contact.middleName

        PersistentStorage.shared.saveContext()
    }
}
