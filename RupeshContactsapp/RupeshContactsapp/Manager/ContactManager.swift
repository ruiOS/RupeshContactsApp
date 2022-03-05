//
//  ContactManager.swift
//  RupeshContactsApp
//
//  Created by rupesh on 01/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

///Manager to manage contacts
struct ContactManager: BaseManager{

    private let contactRepository: ContactRepository = ContactRepository()

    func create(record: Contact){
        contactRepository.create(record: record)
    }

    func getRecord(usingID id: UUID) -> Contact?{
        contactRepository.get(byIdentifier: id)
    }

    func getAllRecords() -> [Contact]{
        contactRepository.getAll()
    }

    func update(record: Contact) -> Bool{
        contactRepository.update(record: record)
    }

    func deleteRecord(usingID id: UUID) -> Bool{
        contactRepository.delete(usingID: id)
    }

}
