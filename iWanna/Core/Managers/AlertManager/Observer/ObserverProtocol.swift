//
//  ObserverProtocol.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import Foundation

public protocol ObserverProtocol {
    associatedtype Value
    typealias Closure = (_ oldValue: Value, _ newValue: Value) -> Void
    var value: Value { get set }
    mutating func bind(closure: @escaping Closure) -> Value
}
