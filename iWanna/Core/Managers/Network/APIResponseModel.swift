//
//  APIResponseModel.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import Foundation

struct APIResponseErrorModel: Decodable {
    let errors: APIResponseError?
}

struct APIResponseError: Decodable {
    let title: String?
    let status: Int
    let source: APIResponseErrorPointer?
    let detail: String?
}

struct APIResponseErrorPointer: Decodable {
    let pointer: String?
}

struct APIErrorMessage: Error {
    let message: String?
}
