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

    ///method used to get name of contact
    func getName() -> String{
        appendStringWithSpacesBetween(appendStringWithSpacesBetween(self.firstName, self.middleName), self.lastName)
    }

    ///method used to append two strings with spaces
    private func appendStringWithSpacesBetween(_ string1: String?, _ string2: String?) -> String{
        if let string1 = string1, !string1.isEmpty {
            if let string2 = string2, !string2.isEmpty{
                return string1 + " " + string2
            }else{
                return string1
            }
        }else if let string2 = string2, !string2.isEmpty {
            return string2
        }
        return ""
    }

}
