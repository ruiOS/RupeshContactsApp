//
//  String+Extensions.swift
//  RupeshContactsApp
//
//  Created by rupesh-6878 on 03/03/22.
//  Copyright © 2022 rupesh-6878. All rights reserved.
//

import Foundation

extension String {
    public var isValidPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
}
