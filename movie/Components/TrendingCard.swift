//
//  TrendingCard.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import SwiftUI

struct TrendingCard: View {
    @StateObject var viewModel = MovieDiscoverViewModel()
    
    let trendingItem: Movie
    let favorites: [Movie]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 200)
            } placeholder: {
                Rectangle()
                    .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .frame(width: 340, height: 200)
            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer ()
                    Button {
                        Task {
                            if  favorites.contains(where: { $0.id == trendingItem.id })  {
                                await viewModel.deleteFromFavorites(for: trendingItem.id)
                            } else {
                                await viewModel.addToFavourites(for: trendingItem.id)
                            }
                            
                                                    }
                    } label: {
                        Image(systemName:  "heart.fill")
                            .foregroundColor(
                                favorites.contains(where: { $0.id == trendingItem.id }) ? .red : .accentColor
                            )
                    }
                }
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(trendingItem.vote_average, specifier: "%.1f")")
                    Spacer()
                }
                .foregroundColor(.yellow)
            }
            .padding()
            .background(Color(red: 60/255, green: 60/255, blue: 60/255))
        }
        .cornerRadius(10)
    }
}
