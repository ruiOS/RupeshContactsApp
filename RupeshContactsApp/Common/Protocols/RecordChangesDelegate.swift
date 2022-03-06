//
//  RecordChangesDelegate.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

/// delegate to manage records between ViewControllers
protocol RecordChangesDelegate{
    /// call this method after contact is added
    func recordDidAdd()

    /// call this method after contact is deleted
    func recordDidDelete(_ record: RecordProtocol)

    /// call this method after contact is Edited
    func recordDidEdit(_ record: RecordProtocol)
}
