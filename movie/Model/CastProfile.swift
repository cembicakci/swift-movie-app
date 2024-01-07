//
//  CastProfile.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import Foundation

struct CastProfile: Decodable, Identifiable {
    
    let birthday: String?
    let id: Int
    let name: String
    let profile_path: String?
    
    var photoUrl: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w200")
        return baseUrl?.appending(path: profile_path ?? "")
    }
    
}
