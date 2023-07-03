//
//  MovieRequestModel.swift
//  iWanna
//
//  Created by George Weaver on 03.07.2023.
//

import Foundation

struct MovieRequestModel: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case limit
        case yearRange = "year"
        case ratingRange = "rating"
        case genres = "genres.name"
        case countries = "countries.name"
    }
    
    let limit: Int
    let yearRange: String
    let ratingRange: String
    let genres: String
    let countries: String
}
