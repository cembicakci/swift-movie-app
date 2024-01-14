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
    @Published var popular: [Movie] = []
    @Published var upcoming: [Movie] = []
    @Published var favorites: [Movie] = []
    
    func loadTrending() async {
        do {
            let trendingResults: TrendingResults = try await Network.request(endpoint: "trending/movie/day", responseType: TrendingResults.self)
            self.trending = trendingResults.results
        } catch {
            print("loadTrending:", error.localizedDescription)
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
    
    func loadPopular() async {
        do {
            let popularResults: TrendingResults = try await Network.request(endpoint: "movie/popular", responseType: TrendingResults.self)
            self.popular = popularResults.results
        } catch {
            print("popularResults:", error.localizedDescription)
        }
    }
    
    func loadUpcoming() async {
        do {
            let upcomingResulte: TrendingResults = try await Network.request(endpoint: "movie/upcoming", responseType: TrendingResults.self)
            self.upcoming = upcomingResulte.results
        } catch {
            print("upcomingResulte:", error.localizedDescription)
        }
    }
    
    func loadFavourites() async {
        do {
            let results: TrendingResults = try await Network.request(
                endpoint: "account/account_id/favorite/movies",
                responseType: TrendingResults.self
            )
            self.favorites = results.results
            print("favorites", favorites)
        } catch {
            print("loadTrending:", error.localizedDescription)
        }
    }
    
    struct FavoriteResponse: Decodable {
        let status_message: String
        
    }
    
    func addToFavourites(for id: Int) async {
        let bodyData: [String: Any] = [
            "media_type": "movie",
            "media_id": id,
            "favorite": true
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: bodyData)
            let _: FavoriteResponse = try await Network.request(
                endpoint: "account/\(id)/favorite",
                method: .post,
                body: jsonData,
                responseType: FavoriteResponse.self
            )
            
        } catch {
            print("addToFavorites error:", error.localizedDescription)
            
        }
    }
    
    func deleteFromFavorites(for id: Int) async {
        let bodyData: [String: Any] = [
            "media_type": "movie",
            "media_id": id,
            "favorite": false
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: bodyData)
            let _: FavoriteResponse = try await Network.request(
                endpoint: "account/\(id)/favorite",
                method: .post,
                body: jsonData,
                responseType: FavoriteResponse.self
            )
            
        } catch {
            print("addToFavorites error:", error.localizedDescription)
            
        }
    }
    
    func isFavourite(for movie: Movie) -> Bool {
        return favorites.contains(where: { $0.id == movie.id })
    }
}
