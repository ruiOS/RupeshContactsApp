//
//  ContactDetailVCCellDataModel.swift
//  RupeshContactsApp
//
//  Created by rupesh on 01/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreGraphics

///Data model for ContactDetailVCCell
struct ContactDetailVCCellDataModel: ContactDetailVCCellDataModelProtocol{
    
    var placeHolder: String{
        get{
            inputDataType.getPlaceHolder()
        }set{}
    }
    var input: Any?
    var inputDataType: InputDataType
    var cellHeight: CGFloat{
        inputDataType.isContactPic ? 175 : 75
    }
    var isInputEnabled: Bool = true

}
