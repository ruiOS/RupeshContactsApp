//
//  AddContactVCCell.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import UIKit

class AddContactVCCell: UITableViewCell{

    static let reuiseIdentifier = "AddContactVCCell"

    private let placeHolderLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textAlignment = .center
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.backgroundColor = .clear
        return tempLabel
    }()

    private let inputTextField: UITextField = {
        let tempTextField = UITextField()
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        tempTextField.backgroundColor = .clear
        return tempTextField
    }()

    private let contactImageViewButton: UIButton = {
        let tempButton = UIButton()
        if #available(iOS 13.0, *) {
            tempButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        }
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        tempButton.backgroundColor = .clear
        return tempButton
    }()

    private var viewModel: AddContactVCCellDataTypeProtocol?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell(withDataModel datamodel: AddContactVCCellDataTypeProtocol){
        viewModel = datamodel

        debugPrint("In setCell")
        switch datamodel.inputDataType{
        case .contactNumber, .firstName, .lastName, .middleName:
            addViewsForTextEditing()
            self.inputTextField.text = datamodel.input as? String
            self.inputTextField.placeholder = datamodel.placeHolder
        case .contactPic(let isPictureAvailable):
            addViewsForAddingPicture()
            self.placeHolderLabel.text = datamodel.placeHolder
        }
    }

    private func addViewsForTextEditing(){
        self.addSubview(inputTextField)

        NSLayoutConstraint.activate([
            inputTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            NSLayoutConstraint(item: inputTextField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0),
            NSLayoutConstraint(item: inputTextField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.9, constant: 0)
        ])
    }

    private func addViewsForAddingPicture(){

        self.addSubview(contactImageViewButton)
        NSLayoutConstraint.activate([
            contactImageViewButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contactImageViewButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contactImageViewButton.widthAnchor.constraint(equalTo: self.heightAnchor),
            contactImageViewButton.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])

        self.addSubview(placeHolderLabel)

        NSLayoutConstraint.activate([
            placeHolderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            NSLayoutConstraint(item: placeHolderLabel, attribute: .bottom, relatedBy: .equal, toItem: contactImageViewButton, attribute: .bottom, multiplier: 0.9, constant: 0),
            placeHolderLabel.widthAnchor.constraint(equalTo: contactImageViewButton.widthAnchor),
            NSLayoutConstraint(item: placeHolderLabel, attribute: .height, relatedBy: .equal, toItem: contactImageViewButton, attribute: .height, multiplier: 0.3, constant: 0)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        debugPrint("In layoutSubviews")

        self.contactImageViewButton.layer.cornerRadius = (self.imageView?.frame.size.width ?? 0) / 2
        self.contactImageViewButton.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        debugPrint("In prepareForReuse")


        self.placeHolderLabel.text = nil
        placeHolderLabel.removeFromSuperview()

        self.inputTextField.text = nil
        inputTextField.removeFromSuperview()

        if #available(iOS 13.0, *) {
            contactImageViewButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        }
        self.contactImageViewButton.layer.cornerRadius = 0
        contactImageViewButton.removeFromSuperview()
    }

}
