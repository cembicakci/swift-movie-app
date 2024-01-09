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
    
    func movieCredits(for movieId: Int) async {
        
        do {
            let credits: MovieCredits = try await Network.request(endpoint: "movie/\(movieId)/credits", responseType: MovieCredits.self)
            self.credits = credits
            self.cast = credits.cast.sorted(by: { $0.order < $1.order })
            
        } catch {
            print("movieCredits:", error.localizedDescription)
        }
    }
    
    func loadCastProfiles() async {
        do {
            for member in cast {
                let profile: CastProfile = try await Network.request(endpoint: "person/\(member.id)", responseType: CastProfile.self)
                castProfiles.append(profile)
            }
        }
        catch {
            print("loadCastProfiles:", error.localizedDescription)
        }
        
    }
    
}

