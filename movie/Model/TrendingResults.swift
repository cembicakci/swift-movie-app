//
//  TrendingResults.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import Foundation

struct TrendingResults: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
    
}
