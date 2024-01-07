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
        ZStack {
            Color(red: 61/255, green: 61/255, blue: 88/255).ignoresSafeArea()

            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: headerHeight)
                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Spacer()
                    }
                    
                    HStack {
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
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
            .padding(.leading)
        }
        .task {
            await model.movieCredits(for: movie.id)
            await model.loadCastProfiles()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock)
}

