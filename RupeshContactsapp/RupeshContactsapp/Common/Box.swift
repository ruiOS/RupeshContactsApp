//
//  Box.swift
//  RupeshContactsApp
//
//  Created by rupesh on 27/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation

final class Box<Object>{

    typealias Listener = (Object) -> Void
    private var listener: Listener?

    var value: Object {
        didSet {
            listener?(value)
        }
    }

    init(_ value: Object) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

}
