//
//  RCTableViewCell.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import UIKit

class RCTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = AppColors.cellBackGroundColor
        self.imageView?.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
