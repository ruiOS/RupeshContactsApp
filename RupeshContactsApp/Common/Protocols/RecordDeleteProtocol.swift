//
//  RecordDeleteProtocol.swift
//  RupeshContactsApp
//
//  Created by rupesh on 05/03/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import Foundation
import UIKit

protocol RecordDeleteProtocol: AnyObject, ErrorDisplayProtocol{

    associatedtype RecordManager: BaseManager

    var recordManager: RecordManager {get set}

    func recordDeleted(record: RecordProtocol)

}

extension RecordDeleteProtocol where Self: UIViewController{

    func deleteRecordTapped(forRecord record: RecordProtocol){
        let okayAction: ((UIAlertAction)->Void) = { [weak self] _ in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let weakSelf = self else {return}
                if weakSelf.recordManager.deleteRecord(usingID: record.id){
                    DispatchQueue.main.async { [weak self] in
                        self?.recordDeleted(record: record)
                    }
                }
            }
        }
        self.displayError(withTitle: nil, withMessage: AppStrings.common_alert_deleteRecordWarning, withOkAction: okayAction)
    }

}
