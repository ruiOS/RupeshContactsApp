//
//  ContactListController.swift
//  RupeshContactsApp
//
//  Created by rupesh on 06/05/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

/// ViewController that shows the list of contacts
class ContactListController: UIViewController, UITableViewDataSource, UITableViewDelegate, RecordChangesDelegate{

    //MARK: - Data
    ///viewModel for the view
    private let model = ContactListViewModel()

    /// Manager of the data
    private let manager = ContactManager()

    /// GlobalQueue with utility qos
    let globalBackGroundQueue = DispatchQueue.global(qos: .utility)

    private var isReloadTableView: Bool = true

    //MARK: - Views
    ///tableView that display contacts
    private lazy var contactListTableview: RCTableView = RCTableView(onView: self.view, withViewcontroller: self, dataSource: true, delegate: true)

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation bar
        self.title = AppStrings.common_contacts
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentsAddContactForm))

        //register cells to tableView
        contactListTableview.register(ContactListTableViewCell.self, forCellReuseIdentifier: ContactListTableViewCell.reuseIdentifier)

        //set View Model
        setViewModel()
    }

    //MARK: - TableViewData Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.contacts.value.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.reuseIdentifier, for: indexPath) as? ContactListTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = model.contacts.value[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellViewModel = model.contacts.value[indexPath.row]
        let contact = manager.getRecord(usingID: cellViewModel.id)
        let ContactDetailVC = ContactDetailVC(isContactDetail: true, contactChangesDelegate: self, contact: contact)
        ContactDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ContactDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.isReloadTableView = false
            let row = indexPath.row
            if weakSelf.manager.deleteRecord(usingID: weakSelf.model.contacts.value[row].id){
                weakSelf.model.contacts.value.remove(at: row)
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .left)
                    tableView.endUpdates()
                }
            }
        }
    }

    //MARK: - TableViewData Source

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        model.contacts.value[indexPath.row].cellHeight
    }

    //MARK: - RecordChangesDelegate

    func recordDidAdd() {
        globalBackGroundQueue.async { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.model.contacts.value = weakSelf.manager.getAllRecords().map({ContactListCellViewModel(usingContact: $0)})
        }
    }

    func recordDidDelete(_ record: RecordProtocol) {
        globalBackGroundQueue.async { [weak self] in
            guard let weakSelf = self,
                  let index = weakSelf.fetchIndex(forRecord: record) else {return}
            weakSelf.model.contacts.value.remove(at: index)
        }
    }
    
    func recordDidEdit(_ record: RecordProtocol) {
        globalBackGroundQueue.async { [weak self] in
            guard let weakSelf = self,
                  let index = weakSelf.fetchIndex(forRecord: record) else {return}
            guard let newRecord = weakSelf.manager.getRecord(usingID: record.id) else {return}
            weakSelf.model.contacts.value[index] = ContactListCellViewModel(usingContact: newRecord)
        }
    }

    private func fetchIndex(forRecord record: RecordProtocol) -> Int?{
        let id = record.id
        guard let index = model.contacts.value.firstIndex(where: {$0.id == id}) else {return nil}
        return index
    }

    //MARK: - Private
    ///presents add Contact form
    @objc private func presentsAddContactForm(){
        let ContactDetailVC = ContactDetailVC(isContactDetail: false, contactChangesDelegate: self, contact: nil)
        ContactDetailVC.hidesBottomBarWhenPushed = true
        self.present(UINavigationController(rootViewController: ContactDetailVC), animated: true, completion: nil)
    }

    
    /// set model and method calls for the model
    private func setViewModel(){
        globalBackGroundQueue.async { [weak self] in
            guard let weakSelf = self else { return }

            //set Contacts
            weakSelf.model.contacts.value = weakSelf.manager.getAllRecords().map({ContactListCellViewModel(usingContact: $0)})
            //set binding
            weakSelf.model.contacts.bindAndFire(listener: { [weak self] contacts in
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else {return}
                    guard weakSelf.isReloadTableView else {
                        weakSelf.isReloadTableView = true
                        return
                    }
                    weakSelf.contactListTableview.reloadData()
                }
            })
        }
    }

}
