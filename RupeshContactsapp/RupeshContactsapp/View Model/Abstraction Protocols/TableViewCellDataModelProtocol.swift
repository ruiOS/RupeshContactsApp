//
//  TableViewCellDataModelProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 02/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import CoreGraphics

///use this to create datamodel for cells
protocol TableViewCellDataModelProtocol{

    var title: String{get set}
    var subTitle: String?{get set}
    var cellHeight: CGFloat {get set}

}

///use this to create datamodel for cells with image data
protocol TableViewCellImageDataModelProtocol{
    var imageData: Data? { get set }
}
