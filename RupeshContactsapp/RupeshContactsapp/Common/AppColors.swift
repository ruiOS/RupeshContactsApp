//
//  AppColors.swift
//  RupeshContactsApp
//
//  Created by rupesh on 03/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

///A struct that provides Default colors in the app
struct AppColors{
    ///default backGroundColor
    static var backGroundColor: UIColor = .white
}

//Set colors for different interface modes in iOS 13 and Above
@available(iOS 13,*)
extension AppColors{

    ///method to change color for iOS 13 anad above for different interface modes. Call it during app launch to set colors for iOS13 and above
    static func setColorsForiOS13(){
        self.backGroundColor = .systemBackground
    }
}
