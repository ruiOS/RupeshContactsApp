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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView?.contentMode = .scaleToFill

    }

    func setCell(withDataModel datamodel: Contact){
        self.textLabel?.text = getName(fromContact: datamodel)
        self.detailTextLabel?.text = datamodel.contactNumber
        guard let imgData = datamodel.contactPic else { return }
        self.imageView?.image = UIImage(data: imgData)
    }

    private func getName(fromContact contact: Contact) -> String{
        appendStringWithSpacesBetween(appendStringWithSpacesBetween(contact.firstName!, contact.middleName), contact.lastName)
    }

    private func appendStringWithSpacesBetween(_ string1: String, _ string2: String?) -> String{
        guard let string2 = string2, !string2.isEmpty else {
            return string1
        }
        return string1 + "" + string2
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
