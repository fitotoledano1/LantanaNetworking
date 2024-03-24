//
//  LantanaAPIError.swift
//  
//
//  Created by Fito Toledano on 24/03/2024.
//

import Foundation

public enum LantanaAPIError: String, Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
