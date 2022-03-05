//
//  BaseManager.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

///BaseRecord Manager for all record management Protocols
protocol BaseManager{

    ///Record Item type to be fetched
    associatedtype Item: RecordProtocol

    ///creates record
    func create(record: Item)

    //fetches record by id
    func getRecord(usingID id: UUID) -> Item?

    ///returns all records
    func getAllRecords() -> [Item]

    ///updates given record
    func update(record: Item) -> Bool

    ///deletes record by using id
    func deleteRecord(usingID id: UUID) -> Bool
}
