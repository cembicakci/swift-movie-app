//
//  Network.swift
//  movie
//
//  Created by Cem Bıçakcı on 8.01.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Network {
    static let apiKey = "409d993d44e607bd146c738c9df97a95"
    static let baseURL = "https://api.themoviedb.org/3/"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDlkOTkzZDQ0ZTYwN2JkMTQ2YzczOGM5ZGY5N2E5NSIsInN1YiI6IjYyMDNmYjRkNGRmMjkxMDA2OTFjM2M5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DDE74BuHNhMq6eeElOXjNTkLHaBwPgPZBc_jCHjZXWg"
    
    static func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        var components = URLComponents(string: baseURL + endpoint)
        components?.queryItems = queryItems + [URLQueryItem(name: "api_key", value: apiKey)]

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        request.allHTTPHeaderFields = headers
        
        
        if let body = body {
            request.httpBody = body as Data
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(responseType, from: data)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
