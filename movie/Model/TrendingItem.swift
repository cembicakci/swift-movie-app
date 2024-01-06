//
//  TrendingItem.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import Foundation

struct TrendingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
    let backdrop_path: String
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(backdrop_path)")!
    }
}
