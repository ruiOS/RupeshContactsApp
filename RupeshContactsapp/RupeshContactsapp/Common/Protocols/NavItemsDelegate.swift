//
//  NavItemsDelegate.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import UIKit

enum DetailFormBarButtonItem{
    case done
    case add
    case edit
    case cancel
    case close
    case back
}

@objc protocol DetailFormNavBarDelegate{

    @objc func editButtonPressed()
    @objc func doneButtonPressed()
    @objc func addButtonPressed()
    @objc func cancelButtonPressed()
    @objc func closeButtonPressed()
    @objc func backButtonPressed()
    @objc func deleteButtonPressed()

}

extension DetailFormNavBarDelegate where Self: UIViewController{

    func addNavBarButtonItem(ofType type: DetailFormBarButtonItem){
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {return}
            switch type {
            case .done:
                weakSelf.navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppStrings.common_done, style: .done, target: self, action: #selector(weakSelf.doneButtonPressed))
            case .add:
                weakSelf.navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppStrings.common_add, style: .done, target: self, action: #selector(weakSelf.addButtonPressed))
            case .edit:
                let editButton = UIBarButtonItem(title: AppStrings.common_edit, style: .done, target: self, action: #selector(weakSelf.editButtonPressed))
                let deleteButton = UIBarButtonItem(title: AppStrings.common_delete, style: .done, target: self, action: #selector(weakSelf.deleteButtonPressed))
                deleteButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColors.deleteButtonColor], for: .normal)
                
                weakSelf.navigationItem.rightBarButtonItems = [deleteButton, editButton]
            case .cancel:
                weakSelf.navigationItem.leftBarButtonItem = UIBarButtonItem(title: AppStrings.common_cancel, style: .plain, target: self, action: #selector(weakSelf.cancelButtonPressed))
            case .close:
                weakSelf.navigationItem.leftBarButtonItem = UIBarButtonItem(title: AppStrings.common_close, style: .plain, target: self, action: #selector(weakSelf.closeButtonPressed))
            case .back:
                weakSelf.navigationItem.leftBarButtonItem = UIBarButtonItem(title: AppStrings.common_back, style: .plain, target: self, action: #selector(weakSelf.backButtonPressed))
            }
        }
    }

}
