//
//  TextFieldEditingEventsDelegate.swift
//  RupeshContactsApp
//
//  Created by rupesh-6878 on 02/03/22.
//  Copyright © 2022 rupesh-6878. All rights reserved.
//

import Foundation
import UIKit.UITextField

@objc protocol TextFieldEditingEventsDelegate{
    @objc func textFieldDidChange(_ textField: UITextField)
}

extension TextFieldEditingEventsDelegate where Self:NSObject{

    func setEditingEventsObserver(forTextField textField: UITextField){
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

}
