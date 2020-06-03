//
//  AppSettingsManager.swift
//  RupeshContactsApp
//
//  Created by rupesh on 03/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import Foundation

///An interface to the user’s defaults settings, where you store user's personalised settings persistently across launches of your app.
class AppSettingsManager {

    ///Private intialiser
    private init(){}

    ///returns the shared AppSettingsManager Object
    static let shared: AppSettingsManager = AppSettingsManager()

}
