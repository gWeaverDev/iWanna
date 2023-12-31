//
//  UITableView+Register.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

extension UITableView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: Reusable>(viewType: T.Type) {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }

}
