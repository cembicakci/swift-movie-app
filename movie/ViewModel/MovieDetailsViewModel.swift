//
//  MovieDetailsViewModel.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    
    @Published var credits: MovieCredits?
    
    private let apiKey = "409d993d44e607bd146c738c9df97a95"
    
    func movieCredits(for movieId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(apiKey)&language=en-US")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
            self.credits = credits
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
