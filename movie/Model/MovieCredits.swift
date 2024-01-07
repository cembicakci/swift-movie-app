//
//  MovieCredits.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import Foundation

struct MovieCredits: Decodable {
    let id: Int
    let cast: [Cast]
    
    struct Cast: Decodable, Identifiable {
        
        let name: String
        let id: Int
        let character: String
        let order: Int
        
    }
}
