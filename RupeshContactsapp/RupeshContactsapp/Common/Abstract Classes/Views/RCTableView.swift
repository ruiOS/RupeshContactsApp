//
//  RCTableView.swift
//  RupeshContactsApp
//
//  Created by rupesh-6878 on 28/02/22.
//  Copyright © 2022 rupesh-6878. All rights reserved.
//

import UIKit

class RCTableView: UITableView {

    //MARK:- Intializers
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.intialSetUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience  init(onView view: UIView? = nil,
                      withViewcontroller viewController: UIViewController? = nil,
                      dataSource: Bool = false,
                      delegate: Bool = false,
                      witPaddingLeft: CGFloat = 0,
                      right: CGFloat = 0,
                      top:CGFloat = 0,
                      bottom: CGFloat = 0,
                      frame: CGRect = .zero,
                      style: UITableView.Style = .plain) {
        self.init(frame: frame, style: style)
        if view != nil{
            self.addToView(onView: view!, paddingLeft: witPaddingLeft,paddingRight: right,paddingTop:top,paddingBottom:bottom)
        }
        if viewController != nil{
            self.dataSource = dataSource ? viewController as? UITableViewDataSource : nil
            self.delegate = delegate ? viewController as? UITableViewDelegate : nil
        }
    }
 
    private func intialSetUp(){
        self.backgroundColor    =   AppColors.backGroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rowHeight          =   UITableView.automaticDimension

        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0.0
        }

    }

    private func addToView(onView view: UIView, paddingLeft: CGFloat = 0,paddingRight: CGFloat = 0,paddingTop:CGFloat = 0,paddingBottom: CGFloat = 0){
        view.addSubview(self)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingTop),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: paddingBottom),
            self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingLeft),
            self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: paddingRight),
        ])
    }


}
