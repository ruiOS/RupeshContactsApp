//
//  RCTableViewCell.swift
//  RupeshContactsApp
//
//  Created by rupesh-6878 on 28/02/22.
//  Copyright © 2022 rupesh-6878. All rights reserved.
//

import UIKit

class RCTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = AppColors.backGroundColor
        self.imageView?.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
