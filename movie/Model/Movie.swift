//
//  TrendingItem.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let vote_average: Float
    let backdrop_path: String?
    
    var backdropURL: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w300")
        return baseUrl?.appending(path: backdrop_path ?? "")
    }
    
    var postThumbnail: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w300")
        return baseUrl?.appending(path: poster_path ?? "")
    }
}
