//
//  MovieResponseModel.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import Foundation

struct MovieResponseModel: Decodable {
    var docs: [MovieDocs]
}

struct MovieDocs: Decodable {
    var id: Int
    var name: String?
    var year: Int?
    var description: String?
    var rating: MovieRating?
    var poster: MoviePoster?
    var genres: [MoviewGenres]
    var countries: [MovieCountires]
}

struct MovieRating: Decodable {
    var kp: Double?
}

struct MoviePoster: Decodable {
    var url: String?
    var previewUrl: String?
}

struct MoviewGenres: Codable {
    var name: String?
}

struct MovieCountires: Codable {
    var name: String?
}
