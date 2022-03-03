//
//  AddContactVCCell.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import UIKit

///Delegate used to open image picker from cell
@objc protocol ContactImagePickerDelegate{
    ///method used to open image picker
    @objc func openImagePicker()
}

/// delegate of methos used in AddContact VC Cell
protocol AddContactVCCellDelegate: ContactImagePickerDelegate{
    /**
     called when view model's input data is changes
     - parameter newCellViewModel: new model after input is changed
     */
    func viewModelInputDidChange(newCellViewModel: AddContactVCCellDataModelProtocol?)

    /**
     method called when textfield input value is changed
     - parameter viewModel: viewmodel after input is updated
     */
    func textFieldInputDidChange(viewModel: AddContactVCCellDataModelProtocol?)
}

///cell used to input contact object values
class AddContactVCCell: RCTableViewCell, UITextFieldDelegate, TextFieldEditingEventsDelegate{

    //MARK: - Views
    ///placeHolderLabel to show contact numbers
    private let placeHolderLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textAlignment = .center
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.backgroundColor = AppColors.gray
        tempLabel.alpha = 0.7
        return tempLabel
    }()

    let inputTextField: UITextField = {
        let tempTextField = UITextField()
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        tempTextField.backgroundColor = .clear
        tempTextField.keyboardType = .alphabet
        tempTextField.returnKeyType = .next
        return tempTextField
    }()

    private let contactImageViewButton: UIButton = {
        let tempButton = UIButton()
        if #available(iOS 13.0, *) {
            tempButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        }
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        tempButton.backgroundColor = AppColors.backGroundColor
        return tempButton
    }()

    //MARK: - Data
    ///reuse identifier of cell
    static let reuseIdentifier = "AddContactVCCell"

    ///delegate to handle input data changes
    var delegate: (AddContactVCCellDelegate)?{
        didSet{
            contactImageViewButton.removeTarget(self, action: nil, for: .touchUpInside)
            if let delegate = delegate,
               let viewModel = viewModel,
               viewModel.inputDataType.isContactPic {
                contactImageViewButton.addTarget(delegate, action: #selector(delegate.openImagePicker), for: .touchUpInside)
            }
        }
    }

    //MARK: - ViewModel
    ///viewModel of the cell
    var viewModel: AddContactVCCellDataModelProtocol?{
        didSet{
            guard let viewModel = viewModel else {return}
            func setTextField(){
                addViewsForTextEditing()
                self.inputTextField.text = viewModel.input as? String
                self.inputTextField.placeholder = viewModel.placeHolder
            }
            switch viewModel.inputDataType{
            case .firstName, .lastName, .middleName:
                setTextField()
            case .contactNumber:
                self.inputTextField.keyboardType = .phonePad
                self.inputTextField.returnKeyType = .default
                setTextField()
            case .contactPic(let isPictureAvailable):
                addViewsForAddingPicture()
                backgroundColor = AppColors.tableViewBackGroundColor
                if isPictureAvailable,
                   let imageData = viewModel.input as? Data{
                    self.contactImageViewButton.setImage(UIImage(data: imageData), for: .normal)
                    self.contactImageViewButton.backgroundColor = .clear
                }
                self.placeHolderLabel.text = viewModel.placeHolder
            }
        }
    }

    //MARK: -  Initialisers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        //set cell
        self.selectionStyle = .none
        inputTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.contactImageViewButton.layer.cornerRadius = (self.contactImageViewButton.frame.size.width) / 2
        self.contactImageViewButton.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        backgroundColor = AppColors.cellBackGroundColor

        delegate = nil

        self.placeHolderLabel.text = nil
        placeHolderLabel.removeFromSuperview()

        self.inputTextField.text = nil
        inputTextField.keyboardType = .alphabet
        inputTextField.returnKeyType = .next
        inputTextField.removeFromSuperview()

        if #available(iOS 13.0, *) {
            contactImageViewButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        }
        contactImageViewButton.backgroundColor = AppColors.backGroundColor
        self.contactImageViewButton.layer.cornerRadius = 0
        contactImageViewButton.removeFromSuperview()
    }

    //MARK: - Set Views
    ///method adds input textField to the cell and sets it's delegate
    private func addViewsForTextEditing(){
        self.contentView.addSubview(inputTextField)
        setEditingEventsObserver(forTextField: inputTextField)

        NSLayoutConstraint.activate([
            inputTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            NSLayoutConstraint(item: inputTextField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0),
            NSLayoutConstraint(item: inputTextField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.9, constant: 0)
        ])
    }

    ///method adds contactImageViewButton to the cell
    private func addViewsForAddingPicture(){

        self.contentView.addSubview(contactImageViewButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contactImageViewButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.9, constant: 0),
            contactImageViewButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contactImageViewButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            contactImageViewButton.heightAnchor.constraint(equalTo: contactImageViewButton.widthAnchor)
        ])

        contactImageViewButton.addSubview(placeHolderLabel)

        NSLayoutConstraint.activate([
            placeHolderLabel.centerXAnchor.constraint(equalTo: contactImageViewButton.centerXAnchor),
            NSLayoutConstraint(item: placeHolderLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 0.75, constant: 0),
            placeHolderLabel.widthAnchor.constraint(equalTo: contactImageViewButton.widthAnchor),
            NSLayoutConstraint(item: placeHolderLabel, attribute: .height, relatedBy: .equal, toItem: contactImageViewButton, attribute: .height, multiplier: 0.5, constant: 0)
        ])
    }

    //MARK: - UITExtField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        defer{
            delegate?.textFieldInputDidChange(viewModel: self.viewModel)
        }
        return true
    }

    func textFieldDidChange(_ textField: UITextField) {
        viewModel?.input = textField.text
        delegate?.viewModelInputDidChange(newCellViewModel: viewModel)
    }

}
