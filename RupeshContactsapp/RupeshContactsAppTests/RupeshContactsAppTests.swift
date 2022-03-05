//
//  RupeshContactsAppTests.swift
//  RupeshContactsAppTests
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import XCTest
@testable import RupeshContactsApp

class RupeshContactsAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactTestCases(){

        let contact1 = Contact(contactNumber: "080080", contactPic: nil, firstName: "Rupesh", lastName: "Kumar", middleName: "Pudota", id: UUID())
        let contact2 = Contact(contactNumber: "0909809", contactPic: nil, firstName: "Kate", lastName: nil, middleName: "Winsley", id: UUID())
        let contact3 = Contact(contactNumber: "0809808", contactPic: nil, firstName: "Robbert", lastName: "Pattinson", middleName: nil, id: UUID())
        let contact4 = Contact(contactNumber: "080890", contactPic: nil, firstName: nil, lastName: "James", middleName: "Downey", id: UUID())
        let contact5 = Contact(contactNumber: "099090", contactPic: nil, firstName: "Jesse", lastName: "Robertson", middleName: nil, id: UUID())
        let contact6 = Contact(contactNumber: "0989897", contactPic: nil, firstName: "John", lastName: nil, middleName: nil, id: UUID())

        let contactList = [contact1, contact2, contact3, contact4, contact5, contact6]
        testContact(withContact: contact1)

        testContact(withContact: contact2)
        testContact(withContact: contact3)
        testContact(withContact: contact4)
        testContact(withContact: contact5)
        testContact(withContact: contact6)

        for i in 0..<contactList.count{
            for j in 0..<contactList.count{
                if i == j { continue }
                XCTAssertNotEqual(contactList[i].id, contactList[j].id)
            }
        }

    }

    func testTypes(){
        let viewModel = BoxedContactDetailVCDataModel()
        viewModel.dataFieldModel.value.dataFields = InputDataType.allCases.map({ ContactDetailVCCellDataModel(input: nil, inputDataType: $0)})

        for i in 0..<viewModel.dataFieldModel.value.dataFields.count{
            for j in 0..<viewModel.dataFieldModel.value.dataFields.count{
                if i == j { continue }
                XCTAssertNotEqual(i, j)
            }
        }

        let contact = Contact(contactNumber: viewModel.dataFieldModel.value.contactNumber, contactPic: viewModel.dataFieldModel.value.contactPic, firstName: viewModel.dataFieldModel.value.firstName, lastName: viewModel.dataFieldModel.value.lastName, middleName: viewModel.dataFieldModel.value.middleName, id: UUID())
        let manager = ContactManager()

        manager.create(contact: contact)
    }

    func testContact(withContact contact: Contact){
        let cdContact = CDContact(context: PersistentStorage.shared.context)
        cdContact.bind(contact: contact)
        let _ = cdContact.convertToContact()
        removeContactFromDB(contact: contact)
    }

    func removeContactFromDB(contact: Contact){
        let manager = ContactManager()

        let _ = manager.deleteContact(usingID: contact.id)
    }

}
