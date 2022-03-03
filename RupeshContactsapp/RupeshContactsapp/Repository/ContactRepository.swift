//
//  ContactRepositoryProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreData

/// Protocol  to create a repository for contacts
protocol ContactRepositoryProtocol{
    /**
     Use this method to create a CDContact object and save in DB
     - Parameter contact: Contact type dataModel to be saved as contact
    */
    func create(contact: Contact)
    
    /**
     Returns all contacts from DB
     - returns: array of contacts present in db
     */
    func getAll() -> [Contact]

    /**
     returns contact using id
     
     - parameter id: id of the contact.
     - returns: Contact filtered using id of the contact
     - warning: returns nil value if contact is not present
     */
    func get(byIdentifier id: UUID) -> Contact?

    /**
     update contact and returns if update is successful
     
     - parameter contact: contact needed to be updated
     - returns: returns if contact update is successful
     */
    func update(contact: Contact) -> Bool

    /**
     delete contact and returns if delete is successful
     
     - parameter contact: contact needed to be deleted
     - returns: returns if contact delete is successful
     */
    func delete(usingID id: UUID) -> Bool
}

/**
 Reposiotry handles contact data
 
 - Note
    Inherits from ContactRepositoryProtocol
 */
struct ContactDataRepository: ContactRepositoryProtocol{

    func create(contact: Contact) {
        
        let cdContact = CDContact(context: PersistentStorage.shared.context)

        cdContact.firstName     =   contact.firstName
        cdContact.middleName    =   contact.middleName
        cdContact.lastName      =   contact.lastName
        cdContact.id            =   contact.id
        cdContact.contactNumber =   contact.contactNumber
        cdContact.contactPic    =   contact.contactPic

        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Contact] {
        let result =  PersistentStorage.shared.fetchManagedObject(managedObject: CDContact.self)
        let contactArray = result.map({ $0.convertToContact() })
        return contactArray
    }
    
    func get(byIdentifier id: UUID) -> Contact? {
        guard let fetchResult: [CDContact] = PersistentStorage.shared.fetchObjects(usingPredicate: NSPredicate(format: "id==%@", id as CVarArg), withSortDescriptors: nil),
              !fetchResult.isEmpty else { return nil }
        return fetchResult.first?.convertToContact()
    }
    
    func update(contact: Contact) -> Bool {
        guard let fetchResult: [CDContact] = PersistentStorage.shared.fetchObjects(usingPredicate: NSPredicate(format: "id==%@", contact.id as CVarArg), withSortDescriptors: nil),
              !fetchResult.isEmpty,
              let cdContact = fetchResult.first else { return false}

        cdContact.firstName     =   contact.firstName
        cdContact.middleName    =   contact.middleName
        cdContact.lastName      =   contact.lastName
        cdContact.id            =   contact.id
        cdContact.contactNumber =   contact.contactNumber
        cdContact.contactPic    =   contact.contactPic

        PersistentStorage.shared.saveContext()
        return true

    }
    
    func delete(usingID id: UUID) -> Bool {
        guard let fetchResult: [CDContact] = PersistentStorage.shared.fetchObjects(usingPredicate: NSPredicate(format: "id==%@", id as CVarArg), withSortDescriptors: nil),
              !fetchResult.isEmpty,
              let cdContact = fetchResult.first else { return false}
        PersistentStorage.shared.context.delete(cdContact)
        PersistentStorage.shared.saveContext()
        return true
    }

}
