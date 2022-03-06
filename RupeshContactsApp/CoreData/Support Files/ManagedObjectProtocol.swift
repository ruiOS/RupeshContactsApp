//
//  ManagedObjectProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

///NSManagedObject methods to access managedObject in app
protocol NSManagedObjectEntityProtocol{
    ///entityname of the object
    static var entityName: String {get}
}
