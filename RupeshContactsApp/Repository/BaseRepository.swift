//
//  BaseRepository.swift
//  RupeshrecordsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

/// Protocol  to create a repository for records
protocol BaseRepository{

    associatedtype Item
    /**
     Use this method to create a CDrecord object and save in DB
     - Parameter record: record type dataModel to be saved as record
    */
    func create(record: Item)
    
    /**
     Returns all records from DB
     - returns: array of records present in db
     */
    func getAll() -> [Item]

    /**
     returns record using id
     
     - parameter id: id of the record.
     - returns: record filtered using id of the record
     - warning: returns nil value if record is not present
     */
    func get(byIdentifier id: UUID) -> Item?

    /**
     update record and returns if update is successful
     
     - parameter record: record needed to be updated
     - returns: returns if record update is successful
     */
    func update(record: Item) -> Bool

    /**
     delete record and returns if delete is successful
     
     - parameter record: record needed to be deleted
     - returns: returns if record delete is successful
     */
    func delete(usingID id: UUID) -> Bool
}
