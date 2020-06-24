//
//  ContactListTableViewCell.swift
//  RupeshContactsApp
//
//  Created by rupesh on 04/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

///Cell used to display contacts
class ContactListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView?.contentMode = .scaleToFill

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.layer.cornerRadius = (self.imageView?.frame.size.width ?? 0) / 2
        self.imageView?.layer.masksToBounds = true
    }

}
