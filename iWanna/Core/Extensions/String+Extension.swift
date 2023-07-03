//
//  String+Extension.swift
//  iWanna
//
//  Created by George Weaver on 03.07.2023.
//

import Foundation

extension String {
    
    // for parametrs in request
    func mapGenre() -> String {
        switch self {
        case "action":
            return "боевик"
        case "fantastic":
            return "фантастика"
        case "drama":
            return "драма"
        default:
            return self
        }
    }
    
    func mapCountry() -> String {
        switch self {
        case "Russia":
            return "Россия"
        case "USA":
            return "США"
        case "France":
            return "Франция"
        default:
            return self
        }
    }
}
