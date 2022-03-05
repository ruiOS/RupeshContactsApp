//
//  ContactRepository.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreData


/**
 Reposiotry handles contact data
 
 - Note
    Inherits from BaseRepositoy
 */
struct ContactRepository: BaseRepository{

    func create(record contact: Contact) {
        
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
    
    func update(record contact: Contact) -> Bool {
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
