//
//  CDContact+CoreDataProperties.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//
//

import Foundation
import CoreData

extension CDContact {

    ///contactNumber of contact
    @NSManaged public var contactNumber: String?

    ///firstName of contact
    @NSManaged public var firstName: String?

    ///contactPic of contact
    @NSManaged public var contactPic: Data?

    ///id of contact
    @NSManaged public var id: UUID

    ///lastName of contact
    @NSManaged public var lastName: String?

    ///middleName of contact
    @NSManaged public var middleName: String?

    ///groups which have current contact as a number
    @NSManaged public var toCDContactGroup: Set<CDContactGroup>?

}


// MARK: Generated accessors for toCDContactGroup
extension CDContact {

    @objc(addToCDContactGroupObject:)
    @NSManaged public func addToToCDContactGroup(_ value: CDContactGroup)

    @objc(removeToCDContactGroupObject:)
    @NSManaged public func removeFromToCDContactGroup(_ value: CDContactGroup)

    @objc(addToCDContactGroup:)
    @NSManaged public func addToToCDContactGroup(_ values: Set<CDContactGroup>)

    @objc(removeToCDContactGroup:)
    @NSManaged public func removeFromToCDContactGroup(_ values: Set<CDContactGroup>)

}
