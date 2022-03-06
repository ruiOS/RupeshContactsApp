//
//  CDContactGroup+CoreDataProperties.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//
//

import Foundation
import CoreData

extension CDContactGroup {

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var toCDContact: Set<CDContact>?

}

// MARK: Generated accessors for toCDContact
extension CDContactGroup {

    @objc(addToCDContactObject:)
    @NSManaged public func addToToCDContact(_ value: CDContact)

    @objc(removeToCDContactObject:)
    @NSManaged public func removeFromToCDContact(_ value: CDContact)

    @objc(addToCDContact:)
    @NSManaged public func addToToCDContact(_ values: Set<CDContact>)

    @objc(removeToCDContact:)
    @NSManaged public func removeFromToCDContact(_ values: Set<CDContact>)

}
