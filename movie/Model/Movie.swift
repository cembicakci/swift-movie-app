//
//  TrendingItem.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import Foundation

struct Movie: Identifiable, Codable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?
    
    var backdropURL: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseUrl?.appending(path: backdrop_path ?? "")
    }
    
    var postThumbnail: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseUrl?.appending(path: poster_path ?? "")
    }
    
    var poster: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseUrl?.appending(path: poster_path ?? "")
    }
    
    static var mock: Movie {
        return Movie(
            adult: false,
            id: 753342,
            poster_path: "/vdpE5pjJVql5aD6pnzRqlFmgxXf.jpg",
            title: "Napoleon",
            overview: "An epic that details the checkered rise and fall of French Emperor Napoleon Bonaparte and his relentless journey to power through the prism of his addictive, volatile relationship with his wife, Josephine.",
            vote_average: 5.5,
            backdrop_path: "/vdpE5pjJVql5aD6pnzRqlFmgxXf.jpg"
        )
    }
}
