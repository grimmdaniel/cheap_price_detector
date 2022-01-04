//
//  NetworkError.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 18..
//

import Foundation

enum NetworkError: Error, Equatable {
    case badURL
    case internalServerError
    case responseError
    case JSONFormatError
    case NOStatusCode
    case badRequest
    case notFound404
    case semanticError(errorMessage: String)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        
        //TODO add localizations
        case .badURL:
            return "The given url is not valid."
        case .internalServerError:
            return "The server encountered an internal error, please try again later."
        case .responseError:
            return "There is no response from the server, please try again later."
        case .JSONFormatError:
            return "The response from the server is malformed, please try again later."
        case .NOStatusCode:
            return "There is no status code, please try again later."
        case .badRequest:
            return "Something unusual happened, please try again later."
        case .notFound404:
            return "Error 404, please try again later."
        case .semanticError(let errorMessage):
            return errorMessage
        }
    }
}
