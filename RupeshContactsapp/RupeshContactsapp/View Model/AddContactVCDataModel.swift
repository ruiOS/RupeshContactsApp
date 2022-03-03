//
//  AddContactVCDataModel.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

enum AddContactRecordError: Error{
    case recordExists
    case dataMissing(String)
    case inputDataInvalid(String)
}

///DataModel for addcontactvc
class AddContactVCDataModel{

    ///box binding of records
    var dataFieldModel: Box<AddContactVCDataFieldModel> = Box(AddContactVCDataFieldModel())

    ///called when data save fails
    var errorHandler: ((AddContactRecordError) -> Void)?

    ///called when data save succeeds
    var successHandler: ((Contact)->Void)?

    ///method used to create contact
    func createContactObject(){

        ///method creates contact
        func createContact(){
            let aContact = Contact(contactNumber: dataFieldModel.value.contactNumber, contactPic: dataFieldModel.value.contactPic, firstName: dataFieldModel.value.firstName, lastName: dataFieldModel.value.lastName, middleName: dataFieldModel.value.middleName, id: UUID())
            successHandler?(aContact)
        }

        if let contactNumber = dataFieldModel.value.contactNumber{
            if contactNumber.isValidPhoneNumber{
                createContact()
            }else{
                errorHandler?(.dataMissing(AppStrings.add_enterValidPhoneNumber))
            }
        }else{
            createContact()
        }
    }
}

///DataFieldModel for addcontactvc
struct AddContactVCDataFieldModel{

    ///dataField models of addContact vc in a  array
    var dataFields: [AddContactVCCellDataModelProtocol] = [AddContactVCCellDataModelProtocol]()

    ///returns contactNumber if exists
    var contactNumber: String? {
        guard let data = dataFields.first(where: {$0.inputDataType == .contactNumber}) else {return nil}
        return data.input as? String
    }

    ///returns firstName if exists
    var firstName: String? {
        guard let data = dataFields.first(where: {$0.inputDataType == .firstName}) else {return nil}
        return data.input as? String
    }

    ///returns middleName if exists
    var middleName: String? {
        guard let data = dataFields.first(where: {$0.inputDataType == .middleName}) else {return nil}
        return data.input as? String
    }

    ///returns lastName if exists
    var lastName: String? {
        guard let data = dataFields.first(where: {$0.inputDataType == .lastName}) else {return nil}
        return data.input as? String
    }

    ///returns contactPicData if exists
    var contactPic: Data? {
        guard let data = dataFields.first(where: {$0.inputDataType.isContactPic}) else {return nil}
        return data.input as? Data
    }

    ///returns if data required to create contact exists
    var isDataExistsToCreateContact: Bool{
        if let contactNumber = contactNumber, !contactNumber.isEmpty {
            return true
        }else if let firstName = firstName, !firstName.isEmpty {
            return true
        }else if let middleName = middleName, !middleName.isEmpty {
            return true
        }else if let lastName = lastName, !lastName.isEmpty {
            return true
        }else if let contactPic = contactPic, !contactPic.isEmpty {
            return true
        }
        return false
    }

}
