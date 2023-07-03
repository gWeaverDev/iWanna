//
//  MainService.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import Foundation
import Moya

protocol MainServiceProtocol {
    func getMovies(request: MovieRequestModel,
                   completion: @escaping (Result<MovieResponseModel, APIErrorMessage>) -> Void)
    func getMovie(by id: Int, completion: @escaping (Result<MovieDocs, APIErrorMessage>) -> Void)
}

final class MainService: MainServiceProtocol {
    
    private let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    
    func getMovies(
        request: MovieRequestModel,
        completion: @escaping (Result<MovieResponseModel, APIErrorMessage>) -> Void
    ) {
        apiManager.request(MainTarget.getMovies(request: request)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let model = try? response.map(MovieResponseModel.self) else {
                        completion(.failure(.init(message: response.description)))
                        return
                    }
                    completion(.success(.init(docs: model.docs)))
                case 400...500:
                    guard let model = try? response.map(APIResponseErrorModel.self) else {
                        completion(.failure(.init(message: response.description)))
                        return
                    }
                    completion(.failure(.init(message: model.errors?.detail)))
                default:
                    completion(.failure(.init(message: L10n.networkErrorUnknow())))
                }
            case .failure(let error):
                completion(.failure(.init(message: error.localizedDescription)))
            }
        }
    }
    
    func getMovie(by id: Int, completion: @escaping (Result<MovieDocs, APIErrorMessage>) -> Void) {
        apiManager.request(MainTarget.getMovieBy(id)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let model = try? response.map(MovieDocs.self) else {
                        completion(.failure(.init(message: response.description)))
                        return
                    }
                    completion(.success(.init(id: model.id, name: model.name, year: model.year, description: model.description, rating: model.rating, poster: model.poster, genres: model.genres, countries: model.countries)))
                case 400...500:
                    guard let model = try? response.map(APIResponseErrorModel.self) else {
                        completion(.failure(.init(message: response.description)))
                        return
                    }
                    completion(.failure(.init(message: model.errors?.detail)))
                default:
                    completion(.failure(.init(message: L10n.networkErrorUnknow())))
                }
            case .failure(let error):
                completion(.failure(.init(message: error.localizedDescription)))
            }
        }
    }
}
