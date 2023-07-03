//
//  Reusable.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
