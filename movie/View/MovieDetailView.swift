//
//  MovieDetailView.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    
    var body: some View {
        ZStack {
            ScrollView {
                Text(movie.title)
                Text(movie.overview)
            }
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock)
}
