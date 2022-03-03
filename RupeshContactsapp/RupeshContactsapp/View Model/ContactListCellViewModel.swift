//
//  ContactListCellViewModel.swift
//  RupeshContactsApp
//
//  Created by rupesh on 02/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import UIKit

/// view model for ContactListCell
class ContactListCellViewModel: TableViewCellDataModelProtocol, TableViewCellImageDataModelProtocol{

    var cellHeight: CGFloat = 75
    var title: String
    var subTitle: String?
    var imageData: Data?

    ///returns a ContactListCellViewModel object
    init(usingContact contact: Contact){

        ///method used to get name of contact
        func getName(fromContact contact: ContactProtocol) -> String{
            appendStringWithSpacesBetween(appendStringWithSpacesBetween(contact.firstName, contact.middleName), contact.lastName)
        }

        ///method used to append two strings with spaces
        func appendStringWithSpacesBetween(_ string1: String?, _ string2: String?) -> String{
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

        title = getName(fromContact: contact)
        subTitle = contact.contactNumber
        imageData = contact.contactPic
    }


}
