//
//  UITableView+Reusable.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

extension UITableViewCell {
    
    enum Style {
        case mainAction
        case mainCollection
    }

    static var reuseIdentifier: String { String(describing: Self.self) }

    func cellAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}
