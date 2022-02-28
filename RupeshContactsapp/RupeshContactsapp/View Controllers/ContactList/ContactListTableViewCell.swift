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

    static let reuiseIdentifier = "ContactListTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell(withDataModel datamodel: Contact){
        self.textLabel?.text = getName(fromContact: datamodel)
        self.detailTextLabel?.text = datamodel.contactNumber
        guard let imgData = datamodel.contactPic else { return }
        self.imageView?.image = UIImage(data: imgData)
    }

    private func getName(fromContact contact: Contact) -> String{
        appendStringWithSpacesBetween(appendStringWithSpacesBetween(contact.firstName, contact.middleName), contact.lastName)
    }

    private func appendStringWithSpacesBetween(_ string1: String?, _ string2: String?) -> String{
        if let string1 = string1, !string1.isEmpty {
            if let string2 = string2, !string2.isEmpty{
                return string1 + " " + string2
            }else{
                return string1
            }
        }else if let string2 = string2, !string2.isEmpty {
            return string2
        }
        return ""
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.layer.cornerRadius = (self.imageView?.frame.size.width ?? 0) / 2
        self.imageView?.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
