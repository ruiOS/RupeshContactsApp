//
//  AddContactVC.swift
//  RupeshContactsApp
//
//  Created by rupesh on 04/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

/// view controller displays add contact form
class AddContactVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    //MARK: - Data

    ///View model of the viewController
    private let viewModel = AddContactVCDataModel()

    ///manager to manage contacts
    private let manager: ContactManager = ContactManager()

    ///global queue with user initiated qos
    private let userInitiatedGlobalQueue = DispatchQueue.global(qos: .userInitiated)

    ///used to manage contact creation
    private let addContactDelegate: AddContactDelegate

    //MARK: - Views

    ///displays add form data
    private lazy var tableView = RCTableView(onView: self.view, withViewcontroller: self, dataSource: true, delegate: true)

    ///image picker to select contact images
    private let imagePicker: UIImagePickerController =  UIImagePickerController()

    //MARK: - Initialisers
    
    /// returns object of type AddContact VC
    /// - Parameter addContactDelegate: delegate to manage contact creation
    /// - Note method is a convenience intialiser
    convenience init(addContactDelegate: AddContactDelegate){
        self.init(addContactDelegate)
    }

    /// returns object of type AddContact VC
    /// - Parameter addContactDelegate: delegate to manage contact creation
    private init(_ addContactDelegate: AddContactDelegate){
        self.addContactDelegate = addContactDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppStrings.common_add, style: .done, target: self, action: #selector(addContact))
        navigationController?.title = AppStrings.add_newContact

        //tableview
        tableView.register(AddContactVCCell.self, forCellReuseIdentifier: AddContactVCCell.reuseIdentifier)

        //delegate
        imagePicker.delegate = self

        //view model
        setViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.dataFieldModel.value.dataFields.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddContactVCCell.reuseIdentifier, for: indexPath) as? AddContactVCCell else {return UITableViewCell()}
        cell.viewModel = viewModel.dataFieldModel.value.dataFields[indexPath.row]
        cell.delegate = self
        return cell
    }

    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.dataFieldModel.value.dataFields[indexPath.row].cellHeight
    }

    //MARK: - Private
    ///method used to set view model
    private func setViewModel(){
        userInitiatedGlobalQueue.async { [weak self] in
            guard let weakSelf = self else {return}

            weakSelf.viewModel.dataFieldModel.bindAndFire(listener: { [weak self] dataFieldModel in
                DispatchQueue.main.async {  [weak self] in
                    guard let weakSelf = self else {return}
                    weakSelf.navigationItem.rightBarButtonItem?.isEnabled = dataFieldModel.isDataExistsToCreateContact
                }
            })

            weakSelf.viewModel.errorHandler = { [weak self] addContactRecordError in
                self?.userInitiatedGlobalQueue.async { [weak self] in
                    switch addContactRecordError{
                    case .dataMissing(let errorMessage):
                        DispatchQueue.main.async {  [weak self] in
                            guard let weakSelf = self else {return}
                            weakSelf.showAlert(withMessage: errorMessage)
                        }
                    default:
                        break
                    }
                }
            }

            weakSelf.viewModel.successHandler = { [weak self] contact in
                self?.userInitiatedGlobalQueue.async { [weak self] in
                    guard let weakSelf = self else {return}
                    weakSelf.manager.create(contact: contact)
                    weakSelf.addContactDelegate.contactDidAdd()
                }
                DispatchQueue.main.async {  [weak self] in
                    self?.dismiss(animated: true, completion: nil)
                }
            }

            weakSelf.viewModel.dataFieldModel.value.dataFields = InputDataType.allCases.map({ AddContactVCCellDataModel(input: nil, inputDataType: $0)})

        }
    }

    /// calls view model to add contact
    @objc private func addContact(){
        self.view.endEditing(true)
        viewModel.createContactObject()
    }

    
    /// show alert with given message
    /// - Parameter message: message to be show as alert
    private func showAlert(withMessage message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppStrings.common_Ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddContactVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate, AddContactVCCellDelegate{

    //MARK: - AddContactVCCellDelegate
    func openImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }

    func textFieldInputDidChange(viewModel: AddContactVCCellDataModelProtocol?) {

        func makeTextFieldFirstResponder(for inputDataType: InputDataType){
            if let index = self.viewModel.dataFieldModel.value.dataFields.firstIndex(where: {$0.inputDataType == inputDataType}),
               let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? AddContactVCCell{
                cell.inputTextField.becomeFirstResponder()
            }
        }

        switch viewModel?.inputDataType{
        case .firstName:
            makeTextFieldFirstResponder(for: .middleName)
        case .middleName:
            makeTextFieldFirstResponder(for: .lastName)
        case .lastName:
            makeTextFieldFirstResponder(for: .contactNumber)
        default:
            break
        }
    }

    func viewModelInputDidChange(newCellViewModel: AddContactVCCellDataModelProtocol?) {
        viewModel.dataFieldModel.value.dataFields = viewModel.dataFieldModel.value.dataFields.map{
            if $0.inputDataType == newCellViewModel?.inputDataType,
               let newCellViewModel = newCellViewModel{
                return newCellViewModel
            }
            return $0
        }
    }

    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userInitiatedGlobalQueue.async { [weak self] in
            guard let weakSelf = self else {return}
            guard let userPickedImage = info[.originalImage] as? UIImage else { return }

            weakSelf.viewModel.dataFieldModel.value.dataFields = weakSelf.viewModel.dataFieldModel.value.dataFields.map{
                var addContactVCCellData = $0
                if addContactVCCellData.inputDataType.isContactPic
                {
                    addContactVCCellData.inputDataType = .contactPic(true)
                    addContactVCCellData.input = userPickedImage.jpegData(compressionQuality: 0.1)
                }
                return addContactVCCellData
            }

            DispatchQueue.main.async{ [weak self] in
                guard let weakSelf = self else {return}
                if let cellIndex = weakSelf.viewModel.dataFieldModel.value.dataFields.firstIndex(where: {$0.inputDataType.isContactPic}){
                    if let addContactCellsArray = weakSelf.tableView.visibleCells as? [AddContactVCCell]{
                        addContactCellsArray.forEach({
                            if let viewModel = $0.viewModel,
                               viewModel.inputDataType.isContactPic{
                                weakSelf.tableView.reloadRows(at: [IndexPath(row: cellIndex, section: 0)], with: .automatic)
                            }
                        })
                    }
                }
            }
        }

        DispatchQueue.main.async {
            picker.dismiss(animated: true)
        }
    }

    
    //MARK: - Keyboard Notification
    /// handle changes when keyboard is shown
    /// - Parameter notification: notification when keyboard is shown
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //convert it to the same view coords as the tableView it might be colluding
            let convertedFrame = self.tableView.convert(keyboardFrame, from: nil)
            //calculate if the rects intersect
            let intersect = convertedFrame.intersection(self.tableView.bounds)
            //if they do - adjust the insets on tableview to handle it
            let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            let curve = UIView.AnimationOptions(rawValue: UInt((notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: intersect.size.height, right: 0)
            //change the table insets to match - animated to the same duration of the keyboard appearance
            UIView.animate(withDuration: duration, delay: 0.0, options: curve, animations: {[unowned self] in
                self.tableView.contentInset = contentInsets
                self.tableView.scrollIndicatorInsets = contentInsets
            }, completion: nil)
        }
    }

    /// handle changes when keyboard is hidden
    /// - Parameter notification: notification when keyboard is hidden
    @objc func keyboardWillHide(notification: NSNotification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let curve = UIView.AnimationOptions(rawValue: UInt((notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
        let contentInsets = UIEdgeInsets.zero
        UIView.animate(withDuration: duration, delay: 0.0, options: curve, animations: {[unowned self] in
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        }, completion: nil)
    }

}
