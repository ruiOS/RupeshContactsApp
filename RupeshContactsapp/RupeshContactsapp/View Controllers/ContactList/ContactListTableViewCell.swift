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

    //MARK: - Data

    /// cell reuiseIdentifier
    static let reuseIdentifier = "ContactListTableViewCell"

    ///Y Axis and=chor for contact name label
    private lazy var contactNameLabelYAxisAnchor = contactNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor){
        willSet{
            contactNameLabelYAxisAnchor.isActive = false
            newValue.isActive = true
        }
        didSet{
            contactNameLabelYAxisAnchor.isActive = true
        }
    }

    /**
     View model of the cell
     
     - Note :
        Should confirm for TableViewCellDataModelProtocol and TableViewCellImageDataModelProtocol
    */
    var viewModel: (TableViewCellDataModelProtocol & TableViewCellImageDataModelProtocol)! {
        didSet{
            contactNameLabel.text = viewModel.title
            if let subtitle = viewModel.subTitle{
                contactNumberLabel.text = subtitle
                contactNameLabelYAxisAnchor = contactNameLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            }else{
                contactNameLabelYAxisAnchor = contactNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            }
            if let imgData = self.viewModel.imageData {
                let image = UIImage(data: imgData)
                self.contactPicImageView.image = image
            }
            self.contentView.layoutIfNeeded()
            let height = self.contactPicImageView.frame.height
            self.contactPicImageView.layer.cornerRadius = height / 2
            self.contactPicImageView.layer.masksToBounds = true
        }
    }


    //MARK: - Views

    ///imageView that stores contact image
    private let contactPicImageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            tempImageView.image = UIImage(systemName: "person.badge.plus")
        }
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
    }()

    ///uilabel that stores contact name
    private let contactNameLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.backgroundColor = .clear
        tempLabel.textAlignment = .left
        tempLabel.textColor = AppColors.primaryTextColor
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()

    ///uilabel that stores contact number
    private let contactNumberLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.backgroundColor = .clear
        tempLabel.textAlignment = .left
        tempLabel.textColor = AppColors.secondaryTextColor
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()

    //MARK: - Initialisers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()

        if #available(iOS 13.0, *) {
            contactPicImageView.image = UIImage(systemName: "person.badge.plus")
        }

        self.contactPicImageView.layer.cornerRadius = 0
        self.contactPicImageView.layer.masksToBounds = true

        self.contactNameLabel.text = nil
        self.contactNumberLabel.text = nil
    }

    //MARK: - Private Methods
    ///Sets constraints for views in the cell
    private func setViewConstraints(){

        contentView.addSubview(contactPicImageView)
        contentView.addSubview(contactNameLabel)
        contentView.addSubview(contactNumberLabel)

        NSLayoutConstraint.activate([
    
            //contactPicImageView
            contactPicImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            contactPicImageView.heightAnchor.constraint(equalTo: contactPicImageView.widthAnchor),
            contactPicImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            contactPicImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),

            //contactNameLabel
            contactNameLabelYAxisAnchor,
            contactNameLabel.leadingAnchor.constraint(equalTo: self.contactPicImageView.trailingAnchor, constant: 10),
            contactNameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4),
            contactNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),

            //contactNumberLabel
            contactNumberLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2),
            NSLayoutConstraint(item: contactNumberLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 0.8, constant: 0),
            contactNumberLabel.trailingAnchor.constraint(equalTo: self.contactNameLabel.trailingAnchor),
            contactNumberLabel.leadingAnchor.constraint(equalTo: self.contactNameLabel.leadingAnchor)
        ])

    }
}
