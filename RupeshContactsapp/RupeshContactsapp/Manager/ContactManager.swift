//
//  ContactManager.swift
//  RupeshContactsApp
//
//  Created by rupesh on 01/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

struct ContactManager{

    private let contactDataRepository: ContactRepositoryProtocol = ContactDataRepository()

    func create(contact: Contact){
        contactDataRepository.create(contact: contact)
    }

    func getContact(byUUID uuid: UUID) -> Contact?{
        contactDataRepository.get(byIdentifier: uuid)
    }

    func getAllContacts() -> [Contact]{
        contactDataRepository.getAll()
    }

    func update(contact: Contact) -> Bool{
        contactDataRepository.update(contact: contact)
    }

    func deleteContact(usingID id: UUID) -> Bool{
        contactDataRepository.delete(usingID: id)
    }

}
