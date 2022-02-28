//
//  Contact.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

struct Contact: Equatable{

    public var contactNumber: String?
    public var contactPic: Data?
    public var firstName: String?
    public var lastName: String?
    public var middleName: String?
    public var id: UUID

    static func == (lhs: Self, rhs: Self) -> Bool{
        lhs.id == rhs.id
    }

}
