//
//  ContactProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 01/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

///Protocol for contact data models
protocol ContactProtocol: RecordProtocol{

    var contactNumber: String? {get set}
    var contactPic: Data? {get set}
    var firstName: String? {get set}
    var lastName: String? {get set}
    var middleName: String? {get set}

    func getName() -> String

}
