//
//  Contact.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

///Data model to store cdContact
struct Contact: ContactProtocol{

    public var contactNumber: String?
    public var contactPic: Data?
    public var firstName: String?
    public var lastName: String?
    public var middleName: String?
    public var id: UUID

}
