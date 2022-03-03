//
//  ContactListViewModel.swift
//  RupeshContactsApp
//
//  Created by rupesh on 27/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

///View model for contact list
final class ContactListViewModel{

    ///box binding of contacts
    var contacts: Box<[ContactListCellViewModel]> = Box([])

}
