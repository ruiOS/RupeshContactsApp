//
//  CDContact+CoreDataProperties.swift
//  RupeshContactsApp
//
//  Created by rupesh-6878 on 28/02/22.
//  Copyright © 2022 rupesh-6878. All rights reserved.
//
//

import Foundation
import CoreData


extension CDContact: NSManagedObjectEntityProtocol {

    static var entityName: String {
        "CDContact"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContact> {
        return NSFetchRequest<CDContact>(entityName: entityName)
    }

    @NSManaged public var contactNumber: String?
    @NSManaged public var contactPic: Data?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?

    func convertToContact() -> Contact{
        Contact(contactNumber: self.contactNumber, contactPic: self.contactPic, firstName: self.firstName, lastName: self.lastName, middleName: self.middleName, id: self.id)
    }

    
}
