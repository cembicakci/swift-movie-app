//
//  MovieDetailView.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var model = MovieDetailsViewModel()
    
    let movie: Movie
    let headerHeight: CGFloat = 400
    
    var body: some View {
        ScrollView {
            
            VStack {
                AsyncImage(url: movie.backdropURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
            }
            
            
            VStack(spacing: 12) {
                HStack {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                
                
                HStack {
                    Text("About Film")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                Text(movie.overview)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
                
                
                HStack {
                    Text("Cast & Crew")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(model.castProfiles) { cast in
                            CastView(cast: cast)
                        }
                    }
                }
                
            }
            .padding()
        }
        .ignoresSafeArea()
        
        .task {
            await model.movieCredits(for: movie.id)
            await model.loadCastProfiles()
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock)
}

