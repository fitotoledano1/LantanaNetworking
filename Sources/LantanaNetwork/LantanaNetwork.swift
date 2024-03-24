// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

final class NetworkManager {
    private class func constructURL(with endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    static var decoder: JSONDecoder {
        var ftDecoder = JSONDecoder()
        ftDecoder.keyDecodingStrategy = .convertFromSnakeCase
        ftDecoder.dateDecodingStrategy = .iso8601
        return ftDecoder
    }
    
    class func request<T: Decodable>(endpoint: API) async throws -> T {
    static func request<T: Decodable>(endpoint: API) async throws -> T {
        let components = constructURL(with: endpoint)
        guard let url = components.url else {
            throw LantanaAPIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, (200...300).contains(response.statusCode) else {
            throw LantanaAPIError.invalidResponse
        }
        
        let object = try NetworkManager.decoder.decode(T.self, from: data)
        return object
    }
}
