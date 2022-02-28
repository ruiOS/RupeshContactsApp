//
//  AddContactVCCellDataModel.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreGraphics

protocol AddContactVCCellDataTypeProtocol{

    var placeHolder: String {get set}
    var input: Any? {get set}
    var inputDataType: InputDataType {get set}
    var cellHeight: CGFloat {get}


}

struct AddContactVCCellDataType: AddContactVCCellDataTypeProtocol{

    var placeHolder: String
    var input: Any?
    var inputDataType: InputDataType
    var cellHeight: CGFloat{
        inputDataType.isContactPic ? 150 : 75
    }

}

final class AddContactVCCellDataModel{

    var dataFields: Box<[AddContactVCCellDataTypeProtocol]> = Box([])

    var contactNumber: String? {
        guard let data = dataFields.value.first(where: {$0.inputDataType == .contactNumber}) else {return nil}
        return data.input as? String
    }

    var firstName: String? {
        guard let data = dataFields.value.first(where: {$0.inputDataType == .firstName}) else {return nil}
        return data.input as? String
    }

    var middleName: String? {
        guard let data = dataFields.value.first(where: {$0.inputDataType == .middleName}) else {return nil}
        return data.input as? String
    }

    var lastName: String? {
        guard let data = dataFields.value.first(where: {$0.inputDataType == .lastName}) else {return nil}
        return data.input as? String
    }

    var contactPic: Data? {
        guard let data = dataFields.value.first(where: {$0.inputDataType.isContactPic}) else {return nil}
        return data.input as? Data
    }

}
