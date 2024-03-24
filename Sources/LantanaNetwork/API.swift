//
//  API.swift
//  
//
//  Created by Fito Toledano on 24/03/2024.
//

import Foundation

public protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}
