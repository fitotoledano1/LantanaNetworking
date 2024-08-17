//
//  NetworkError.swift
//  
//
//  Created by Fito Toledano on 24/03/2024.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case invalidData
    case unableToComplete
}
