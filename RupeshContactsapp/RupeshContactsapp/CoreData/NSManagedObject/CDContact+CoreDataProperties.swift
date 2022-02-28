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

    static var entityName: String {
        "CDContact"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContact> {
        return NSFetchRequest<CDContact>(entityName: entityName)
    }

    @NSManaged public var contactNumber: String?
    @NSManaged public var contactPic: Data?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?

    func convertToContact() -> Contact{
        Contact(contactNumber: self.contactNumber, contactPic: self.contactPic, firstName: self.firstName, lastName: self.lastName, middleName: self.middleName, id: self.id)
    }

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
