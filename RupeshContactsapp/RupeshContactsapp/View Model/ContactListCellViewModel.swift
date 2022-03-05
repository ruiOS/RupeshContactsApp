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
class ContactListCellViewModel: TableViewCellDataModelProtocol, TableViewCellImageDataModelProtocol, CoreDataCellModelProtocol{

    typealias Item = UUID

    var cellHeight: CGFloat = 75
    var title: String
    var subTitle: String?
    var imageData: Data?
    var id: UUID

    ///returns a ContactListCellViewModel object
    init(usingContact contact: Contact){
        self.title = contact.getName()
        self.subTitle = contact.contactNumber
        self.imageData = contact.contactPic
        self.id =  contact.id
    }


}
