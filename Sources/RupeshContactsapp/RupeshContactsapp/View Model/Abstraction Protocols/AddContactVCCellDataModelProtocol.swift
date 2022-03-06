//
//  ContactDetailVCCellDataModelProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 01/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreGraphics

/// used this to create data models for add form fields
protocol ContactDetailVCCellDataModelProtocol{

    /// place holder of cell
    var placeHolder: String {get set}
    /// input data of cell
    var input: Any? {get set}
    /// input data type of cell
    var inputDataType: InputDataType {get set}
    /// height of cell
    var cellHeight: CGFloat {get}
    ///Returns if input is Enabled
    var isInputEnabled:Bool {get set}

}
