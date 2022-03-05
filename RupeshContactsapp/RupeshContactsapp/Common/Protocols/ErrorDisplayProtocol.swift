//
//  ErrorDisplayProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorDisplayProtocol{
    func displayError(withTitle title: String?, withMessage message: String?, withOkAction okAction: ((UIAlertAction)->Void)?)
}

extension ErrorDisplayProtocol where Self: UIViewController{

    func displayError(withTitle title: String?, withMessage message: String?, withOkAction okAction: ((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppStrings.common_Ok, style: .default, handler: okAction))
        self.present(alert, animated: true, completion: nil)
    }

}
