//
//  UserDefaultsPropertyWrapper.swift
//  RupeshContactsApp
//
//  Created by rupesh on 03/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import Foundation

///A property wrapper to Store all UserDefaults
@propertyWrapper struct UserDefaultsPropertyWrapper<Value>{

    //MARK:- Parameters
    ///Key of User Defaults
    let key: String
    ///Default vaule to be provided if value doesn't exist in the UserDefaults
    let defaultValue: Value
    ///UserDefaults in which value needed to be stored
    let userDefaults: UserDefaults

    ///The default value of the property. Is generic in nature.
    var wrappedValue: Value{
        get{
            //get value for key
            return userDefaults.value(forKey: key) as? Value ?? defaultValue
        }
        set{
            //set value for key
            userDefaults.set(newValue, forKey: key)
        }
    }

    //MARK:- Intialisers
    /// Returns the property wrapper with the following parametes
    /// - Parameters:
    ///   - key: Key of the Value to be accessed
    ///   - defaultValue: Default Value to be provided in case value for key is empty
    ///   - suiteName: An optional that species the suiteName for userDefaults. If not provided the default UserDefaults.standard is considered
    init(key:String,defaultValue:Value,suiteName:String? = nil) {
        //set parameters
        self.key = key
        self.defaultValue = defaultValue
        //intialise userDefaults
        if let _ = suiteName{
            //intialse with suiteName if provided
            userDefaults = UserDefaults(suiteName: suiteName)!
        }else{
            //set default UserDefaults.standard if userDefaults is not provided
            userDefaults = UserDefaults.standard
        }
    }

}
