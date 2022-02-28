//
//  LocalisedString.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

@propertyWrapper struct LocalisedString{
    let key: String
    let comment: String

    var wrappedValue: String{
        get {
            let localisedString = NSLocalizedString(key, comment: comment)
            if key == localisedString{
                return comment
            }else{
                return localisedString
            }
        }
    }
}
