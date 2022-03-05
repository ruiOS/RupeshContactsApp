//
//  CDContactGroup+Extensions.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreData

extension CDContactGroup: NSManagedObjectEntityProtocol {

    /// entity name of the contactGroup
    static var entityName: String {
        "CDContactGroup"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContactGroup> {
        return NSFetchRequest<CDContactGroup>(entityName: entityName)
    }

}
