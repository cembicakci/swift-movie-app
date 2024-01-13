//
//  FavoriteViewModel.swift
//  movie
//
//  Created by Cem Bıçakcı on 13.01.2024.
//

import Foundation


@MainActor
class FavoriteViewModel: ObservableObject {
    
    @Published var favorites: [Movie] = []
    func loadTrending() async {
        do {
            let results: TrendingResults = try await Network.request(
                endpoint: "account/account_id/favorite/movies",
                responseType: TrendingResults.self
            )
            self.favorites = results.results
        } catch {
            print("loadTrending:", error.localizedDescription)
        }
    }
    }
