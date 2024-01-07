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
    @Published var cast: [MovieCredits.Cast] = []
    @Published var castProfiles: [CastProfile] = []
    
    private let apiKey = "409d993d44e607bd146c738c9df97a95"
    
    func movieCredits(for movieId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(apiKey)&language=en-US")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
            self.credits = credits
            self.cast = credits.cast.sorted(by: { $0.order < $1.order })
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCastProfiles() async {
        do {
            for member in cast {
                print(member)
                let url = URL(string: "https://api.themoviedb.org/3/person/\(member.id)?api_key=\(apiKey)&language=en-US")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let profile = try JSONDecoder().decode(CastProfile.self, from: data)
                castProfiles.append(profile)
             }
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
}

