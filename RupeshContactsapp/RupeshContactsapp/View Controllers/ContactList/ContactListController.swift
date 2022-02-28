//
//  ContactListController.swift
//  RupeshContactsApp
//
//  Created by rupesh on 06/05/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

/// ViewController that shows the list of contacts
class ContactListController: UIViewController,UITableViewDataSource {

    let model = ContactListViewModel()

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = AppStrings.common_rupeshContactsApp

        setTableview()

        let repository = ContactDataRepository()

        model.contacts.value = repository.getAll()
    }

    //MARK:- SetTableView
    ///UITableView to display contacts
    let contactListTableview: UITableView = {
        let tempTableView = UITableView()
        tempTableView.translatesAutoresizingMaskIntoConstraints = false
        tempTableView.tableFooterView = UIView()
        return tempTableView
    }()

    private func setTableview(){
        contactListTableview.dataSource = self

        contactListTableview.register(ContactListTableViewCell.self, forCellReuseIdentifier: ContactListTableViewCell.reuiseIdentifier)
        
        self.view.addSubview(contactListTableview)
        contactListTableview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contactListTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contactListTableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contactListTableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

    }

    //MARK:- TableViewData Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.contacts.value.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.reuiseIdentifier, for: indexPath) as? ContactListTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(withDataModel: model.contacts.value[indexPath.row])
        return cell
    }

}
