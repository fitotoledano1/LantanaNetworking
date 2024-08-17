// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class NetworkManager {
    
    private let session: URLSession
    private let baseURL: URL

    public init(baseURL: URL, session: URLSession = .shared) {
        self.session = session
        self.baseURL = baseURL
    }
    
    private func constructURL(with endpoint: API) -> URL {
        baseURL
            .appendingPathComponent(endpoint.path)
            .appending(queryItems: endpoint.parameters)
    }
    
    public static var decoder: JSONDecoder {
        let ftDecoder = JSONDecoder()
        ftDecoder.keyDecodingStrategy = .convertFromSnakeCase
        ftDecoder.dateDecodingStrategy = .iso8601
        return ftDecoder
    }
    
    public func request<T: Decodable>(endpoint: API) async throws -> T {
        let url = constructURL(with: endpoint)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch response.statusCode {
        case 200...300: 
            let object = try NetworkManager.decoder.decode(T.self, from: data)
            return object
        case 400...500: throw NetworkError.clientError(statusCode: response.statusCode)
        case 500...600: throw NetworkError.serverError(statusCode: response.statusCode)
        default: throw NetworkError.invalidResponse
        }
    }
}
