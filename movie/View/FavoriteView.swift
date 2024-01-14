//
//  FavoriteView.swift
//  movie
//
//  Created by Cem Bıçakcı on 13.01.2024.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel = FavoriteViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.favorites) { item in
                            NavigationLink {
                                MovieDetailView(movie: item)
                            } label: {
                                TrendingCard(
                                    trendingItem: item,
                                    favorites: viewModel.favorites
                                )
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
                
                .frame(maxWidth: .infinity)
                .background(
                    Color(red: 30/255, green: 30/255, blue: 30/255)
                        .ignoresSafeArea()
                )
            }
            .navigationTitle("Favorites")
        }
        .onAppear {
            Task {
                await viewModel.loadTrending()
            }
        }
    }
}

#Preview {
    FavoriteView()
}
