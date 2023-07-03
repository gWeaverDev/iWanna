//
//  Dismissible.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

protocol Dismissible: UIView {
    
    var dismiss: (() -> Void)? { get set }
}
