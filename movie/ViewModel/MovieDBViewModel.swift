//
//  MovieDBViewModel.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import Foundation

class MovieDBViewModel: ObservableObject {
    
    @Published var trending: [TrendingItem] = []
    
    private let apiKey = "409d993d44e607bd146c738c9df97a95"
    //static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDlkOTkzZDQ0ZTYwN2JkMTQ2YzczOGM5ZGY5N2E5NSIsInN1YiI6IjYyMDNmYjRkNGRmMjkxMDA2OTFjM2M5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DDE74BuHNhMq6eeElOXjNTkLHaBwPgPZBc_jCHjZXWg"
    
    // https://api.themoviedb.org/3/trending/movie/day?api_key=409d993d44e607bd146c738c9df97a95
    
    func loadTrending() async {
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
            trending = trendingResults.results
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
