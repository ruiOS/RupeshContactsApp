//
//  ContactListController.swift
//  RupeshContactsApp
//
//  Created by rupesh on 06/05/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

/// delegate to add contact
protocol AddContactDelegate{
    /// call this method after contact is added
    func contactDidAdd()
}

/// ViewController that shows the list of contacts
class ContactListController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddContactDelegate{

    //MARK: - Data
    ///viewModel for the view
    private let model = ContactListViewModel()

    /// Manager of the data
    private let manager = ContactManager()

    /// GlobalQueue with utility qos
    let utilityGlobalQueue = DispatchQueue.global(qos: .utility)

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
    }

    //MARK: - TableViewData Source

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        model.contacts.value[indexPath.row].cellHeight
    }

    //MARK: - AddContactDelegate
    func contactDidAdd() {
        utilityGlobalQueue.async { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.model.contacts.value = weakSelf.manager.getAllContacts().map({ContactListCellViewModel(usingContact: $0)})
        }
    }

    //MARK: - Private
    ///presents add Contact form
    @objc private func presentsAddContactForm(){
        let addContactVC = AddContactVC(addContactDelegate: self)
        addContactVC.hidesBottomBarWhenPushed = true
        self.present(UINavigationController(rootViewController: addContactVC), animated: true, completion: nil)
    }

    
    /// set model and method calls for the model
    func setViewModel(){
        utilityGlobalQueue.async { [weak self] in
            guard let weakSelf = self else { return }

            //set Contacts
            weakSelf.model.contacts.value = weakSelf.manager.getAllContacts().map({ContactListCellViewModel(usingContact: $0)})

            //set binding
            weakSelf.model.contacts.bindAndFire(listener: { [weak self] contacts in
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else {return}
                    weakSelf.contactListTableview.reloadData()
                }
            })
        }
    }

}
