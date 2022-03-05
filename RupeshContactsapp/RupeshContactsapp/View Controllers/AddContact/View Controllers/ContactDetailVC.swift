//
//  ContactDetailVC.swift
//  RupeshContactsApp
//
//  Created by rupesh on 04/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

/// view controller displays add contact form
class ContactDetailVC: UIViewController,UITableViewDataSource, UITableViewDelegate, DetailFormNavBarDelegate, RecordDeleteProtocol {

    typealias RecordManager = ContactManager

    //MARK: - Data

    ///View model of the viewController
    private let viewModel = BoxedContactDetailVCDataModel()

    ///manager to manage contacts
    var recordManager: ContactManager = ContactManager()

    ///global queue with user initiated qos
    private let userInitiatedGlobalQueue = DispatchQueue.global(qos: .userInitiated)

    ///used to manage contact creation
    private let contactChangesDelegate: RecordChangesDelegate

    //MARK: - Views

    ///displays add form data
    private lazy var tableView = RCTableView(onView: self.view, withViewcontroller: self, dataSource: true, delegate: true)

    ///image picker to select contact images
    private let imagePicker: UIImagePickerController =  UIImagePickerController()

    private let isContactDetail: Bool

    private lazy var isEditContact: Bool = false{
        didSet{
            if isEditContact{
                addNavBarButtonItem(ofType: .cancel)
                addNavBarButtonItem(ofType: .done)
            }else{
                addNavBarButtonItem(ofType: .back)
                addNavBarButtonItem(ofType: .edit)
            }
        }
    }

    //MARK: - Initialisers
    
    /// returns object of type AddContact VC
    /// - Parameter contactChangesDelegate: delegate to manage contact creation
    /// - Note method is a convenience intialiser
    convenience init(isContactDetail: Bool,
                     contactChangesDelegate: RecordChangesDelegate,
                    contact: Contact?){
        self.init(contact: contact, isContactDetail: isContactDetail,contactChangesDelegate)
    }

    /// returns object of type AddContact VC
    /// - Parameter contactChangesDelegate: delegate to manage contact creation
    private init(contact: Contact?,
                 isContactDetail: Bool,
                 _ contactChangesDelegate: RecordChangesDelegate){

        self.isContactDetail = isContactDetail
        self.contactChangesDelegate = contactChangesDelegate

        if let contact = contact{
            self.viewModel.title = contact.getName()
            self.viewModel.id = contact.id
            self.viewModel.dataFieldModel.value.originalDataFields = InputDataType.allCases.map({
                switch $0{
                case .contactNumber:
                    return ContactDetailVCCellDataModel(input: contact.contactNumber, inputDataType: $0)
                case .firstName:
                    return ContactDetailVCCellDataModel(input: contact.firstName, inputDataType: $0)
                case .lastName:
                    return ContactDetailVCCellDataModel(input: contact.lastName, inputDataType: $0)
                case .middleName:
                    return ContactDetailVCCellDataModel(input: contact.middleName, inputDataType: $0)
                case .contactPic(_):
                    if let contactPic = contact.contactPic{
                        return ContactDetailVCCellDataModel(input: contactPic, inputDataType: .contactPic(true))
                    }else{
                        return ContactDetailVCCellDataModel(input: nil, inputDataType: .contactPic(false))
                    }
                }
            })
            self.viewModel.dataFieldModel.value.dataFields = self.viewModel.dataFieldModel.value.originalDataFields
        }else{
            self.viewModel.dataFieldModel.value.dataFields = InputDataType.allCases.map({ ContactDetailVCCellDataModel(input: nil, inputDataType: $0)})
        }

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar

        if isContactDetail{
            navigationController?.title = AppStrings.add_newContact
            addNavBarButtonItem(ofType: .edit)
            addNavBarButtonItem(ofType: .back)
            viewModel.isInputEnabled = false
            self.navigationItem.hidesBackButton = true
        }else{
            navigationController?.title = viewModel.title
            addNavBarButtonItem(ofType: .add)
            addNavBarButtonItem(ofType: .close)
        }

        //tableview
        tableView.register(ContactDetailVCCell.self, forCellReuseIdentifier: ContactDetailVCCell.reuseIdentifier)

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailVCCell.reuseIdentifier, for: indexPath) as? ContactDetailVCCell else {return UITableViewCell()}
        cell.viewModel = viewModel.dataFieldModel.value.dataFields[indexPath.row]
        cell.delegate = self
        return cell
    }

    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.dataFieldModel.value.dataFields[indexPath.row].cellHeight
    }

    //MARK: - View Model
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
                            weakSelf.displayError(withTitle: nil, withMessage: errorMessage, withOkAction: nil)
                        }
                    default:
                        break
                    }
                }
            }

            weakSelf.viewModel.successHandler = { [weak self] contact in
                self?.userInitiatedGlobalQueue.async { [weak self] in
                    guard let weakSelf = self else {return}
                    if weakSelf.isContactDetail{
                        if weakSelf.recordManager.update(record: contact){
                            weakSelf.contactChangesDelegate.recordDidEdit(contact)
                            weakSelf.isEditContact = false
                        }else{
                            weakSelf.displayError(withTitle: nil, withMessage: AppStrings.form_alert_deleteRecordWarning, withOkAction: nil)
                            return
                        }
                    }else{
                        weakSelf.recordManager.create(record: contact)
                        weakSelf.contactChangesDelegate.recordDidAdd()
                        DispatchQueue.main.async {  [weak self] in
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }

            if weakSelf.isContactDetail{
                weakSelf.viewModel.inputModeChangedClosure = {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }

}

extension ContactDetailVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate, ContactDetailVCCellDelegate{

    //MARK: - ContactDetailVCCellDelegate
    func openImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }

    func textFieldInputDidChange(viewModel: ContactDetailVCCellDataModelProtocol?) {

        func makeTextFieldFirstResponder(for inputDataType: InputDataType){
            if let index = self.viewModel.dataFieldModel.value.dataFields.firstIndex(where: {$0.inputDataType == inputDataType}),
               let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ContactDetailVCCell{
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

    func viewModelInputDidChange(newCellViewModel: ContactDetailVCCellDataModelProtocol?) {
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
                var ContactDetailVCCellData = $0
                if ContactDetailVCCellData.inputDataType.isContactPic
                {
                    ContactDetailVCCellData.inputDataType = .contactPic(true)
                    ContactDetailVCCellData.input = userPickedImage.jpegData(compressionQuality: 0.1)
                }
                return ContactDetailVCCellData
            }

            DispatchQueue.main.async{ [weak self] in
                guard let weakSelf = self else {return}
                if let cellIndex = weakSelf.viewModel.dataFieldModel.value.dataFields.firstIndex(where: {$0.inputDataType.isContactPic}){
                    if let addContactCellsArray = weakSelf.tableView.visibleCells as? [ContactDetailVCCell]{
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

    //MARK: - DetailFormNavBarDelegate

    func editButtonPressed(){
        self.navigationItem.rightBarButtonItems = nil
        addNavBarButtonItem(ofType: .done)
        addNavBarButtonItem(ofType: .cancel)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.viewModel.isInputEnabled = true
        }
    }

    func doneButtonPressed(){
        self.view.endEditing(true)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.viewModel.createContactObject()
            self?.viewModel.isInputEnabled = false
        }
    }

    func addButtonPressed(){
        self.view.endEditing(true)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.viewModel.createContactObject()
        }
    }

    func cancelButtonPressed(){
        if isContactDetail{
            addNavBarButtonItem(ofType: .edit)
            addNavBarButtonItem(ofType: .back)
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.viewModel.dataFieldModel.value.dataFields = weakSelf.viewModel.dataFieldModel.value.originalDataFields
                weakSelf.viewModel.isInputEnabled = false
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }

    func closeButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }

    func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }

    func deleteButtonPressed(){
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let weakSelf = self,
                  let id = weakSelf.viewModel.id,
                  let record = weakSelf.recordManager.getRecord(usingID: id) else {return}
            weakSelf.deleteRecordTapped(forRecord: record)
        }
    }

    //MARK: - RecordDeleteProtocol
    func recordDeleted(record: RecordProtocol) {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.contactChangesDelegate.recordDidDelete(record)
        }
    }
}
