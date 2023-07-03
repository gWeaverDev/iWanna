//
//  Double+Extensions.swift
//  iWanna
//
//  Created by George Weaver on 02.07.2023.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
