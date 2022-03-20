//
//  CDContactGroup+Extensions.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreData

extension CDContactGroup: NSManagedObjectEntityProtocol {

    /// entity name of the contactGroup
    static var entityName: String {
        "CDContactGroup"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContactGroup> {
        return NSFetchRequest<CDContactGroup>(entityName: entityName)
    }

    ///method returns contact value of cdContact
//    func convertToContactGroup() -> Contact{
//        Contact(contactNumber: self.contactNumber, contactPic: self.contactPic, firstName: self.firstName, lastName: self.lastName, middleName: self.middleName, id: self.id)
//    }

    /// method binds contact value to self
    /// - Parameter contact: contact to be binded to self
//    func bind(contact: Contact){
//        self.contactNumber = contact.contactNumber
//        self.contactPic = contact.contactPic
//        self.firstName = contact.firstName
//        self.id = contact.id
//        self.lastName = contact.lastName
//        self.middleName = contact.middleName
//
//        PersistentStorage.shared.saveContext()
//    }
}
