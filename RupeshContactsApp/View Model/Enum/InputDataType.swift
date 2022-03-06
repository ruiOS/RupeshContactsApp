//
//  InputDataType.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

enum InputDataType: CaseIterable, Equatable{

    static var allCases: [InputDataType] = [contactPic(false), firstName, middleName, lastName, contactNumber]

    case contactPic(Bool)
    case firstName
    case middleName
    case lastName
    case contactNumber

    func getPlaceHolder() -> String{
        switch self{
        case .firstName:
            return AppStrings.common_firstName
        case .middleName:
            return AppStrings.common_middleName
        case .lastName:
            return AppStrings.common_lastName
        case .contactNumber:
            return AppStrings.common_contactNumber
        case .contactPic(let isPicAvailable):
            return isPicAvailable ?  AppStrings.common_update : AppStrings.common_add
        }
    }

    var isContactPic: Bool{
        switch self{
        case .contactPic(_):
            return true
        default:
            return false
        }
    }
}
