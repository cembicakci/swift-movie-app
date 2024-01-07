//
//  MovieDetailView.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
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
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock)
}


//struct CastCrewTile: View {
//    
//    let castCrew: CastCrew
//    
//    var body: some View {
//        VStack {
//            AsyncImage(url: castCrew, scale: <#T##CGFloat#>, content: <#T##(Image) -> View#>, placeholder: <#T##() -> View#>)
//        }
//    }
//}
