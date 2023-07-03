//
//  MainTarget.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import Foundation
import Moya

enum MainTarget {
    case getMovies(request: MovieRequestModel)
    case getMovieBy(_ id: Int)
}

extension MainTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1.3") else {
            assertionFailure()
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "movie"
        case .getMovieBy(let id):
            return "movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies, .getMovieBy:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies(let request):
            var parameters: [String: Any] = [:]
            parameters["limit"] = request.limit

            if !request.yearRange.isEmpty {
                parameters["year"] = request.yearRange
            }

            if !request.countries.isEmpty {
                parameters["countries.name"] = request.countries
            }

            if !request.genres.isEmpty {
                parameters["genres.name"] = request.genres
            }

            if !request.ratingRange.isEmpty {
                parameters["rating.kp"] = request.ratingRange
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getMovieBy:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "accept": "application/json",
            "X-API-KEY": UserDefaultsManager().apiToken
        ]
    }
}
