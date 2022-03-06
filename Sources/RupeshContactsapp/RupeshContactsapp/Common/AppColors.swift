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

    ///default gray Color
    static var gray: UIColor = .systemGray

    ///default tableViewBackGroundColor
    static var tableViewBackGroundColor: UIColor = .white

    ///default cellBackGroundColor
    static var cellBackGroundColor: UIColor = .white

    ///default primaryTextColor
    static var primaryTextColor: UIColor = .black

    ///default secondaryTextColor
    static var secondaryTextColor: UIColor = .lightGray

    ///default tabBarTintColor
    static var tabBarTintColor = UIColor(red:0.14, green:0.52, blue:0.97, alpha:1.00)

    static var deleteButtonColor = UIColor.systemRed

}

//Set colors for different interface modes in iOS 13 and Above
@available(iOS 13,*)
extension AppColors{

    ///method to change color for iOS 13 anad above for different interface modes. Call it during app launch to set colors for iOS13 and above
    static func setColorsForiOS13(){
        self.backGroundColor = .systemBackground
        self.cellBackGroundColor = .systemBackground
        self.tableViewBackGroundColor = .secondarySystemBackground
        self.primaryTextColor = setColor(lightModeColor: .black, darkModeColor: .white)
        self.secondaryTextColor = setColor(lightModeColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), darkModeColor: .lightText)
        self.tabBarTintColor = setColor(lightModeColor: UIColor(red:0.14, green:0.52, blue:0.97, alpha:1.00), darkModeColor: UIColor(red:0.07, green:0.52, blue:0.97, alpha:1.00))
    }

    /**
     returns color compatible with both light and dark modes
     
     - parameter lightModeColor: color to be shown in light mode
     - parameter darkModeColor: color to be shown in darkmode
     - returns: color compatible with both light and dark modes
     */
    private static func setColor(lightModeColor: UIColor,darkModeColor: UIColor)->UIColor{
        return UIColor{(traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark{
                return darkModeColor
            }else{
                return lightModeColor
            }
        }
    }
    
}
