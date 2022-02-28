//
//  AddContactVC.swift
//  RupeshContactsApp
//
//  Created by rupesh on 04/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

class AddContactVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    private let viewModel = AddContactVCCellDataModel()

    private lazy var tableView = RCTableView(onView: self.view, withViewcontroller: self, dataSource: true, delegate: true)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))

        viewModel.dataFields.value = InputDataType.allCases.map({ AddContactVCCellDataType(placeHolder: $0.getPlaceHolder(), input: nil, inputDataType: $0)})

        tableView.register(AddContactVCCell.self, forCellReuseIdentifier: AddContactVCCell.reuiseIdentifier)
    }

    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.dataFields.value.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddContactVCCell.reuiseIdentifier, for: indexPath) as? AddContactVCCell else {return UITableViewCell()}
        cell.setCell(withDataModel: viewModel.dataFields.value[indexPath.row])
        return cell
    }

    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.dataFields.value[indexPath.row].cellHeight
    }

    //MARK: - Private
    @objc private func addContact(){

        let contact = Contact(contactNumber: viewModel.contactNumber, contactPic: viewModel.contactPic, firstName: viewModel.firstName, lastName: viewModel.lastName, middleName: viewModel.middleName, id: UUID())
        ContactDataRepository().create(contact: contact)
        self.navigationController?.popViewController(animated: true)
    }
}
