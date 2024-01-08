//
//  MovieDBViewModel.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import Foundation

@MainActor
class MovieDiscoverViewModel: ObservableObject {
    
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    
    func loadTrending() async {
        do {
            let trendingResults: TrendingResults = try await Network.request(endpoint: "trending/movie/day", responseType: TrendingResults.self)
            self.trending = trendingResults.results
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func search(term: String) async {
        let queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "query", value: term)
        ]
        
        do {
            let trendingResults: TrendingResults = try await Network.request(endpoint: "search/movie", queryItems: queryItems, responseType: TrendingResults.self)
            self.searchResults = trendingResults.results
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
