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
            ScrollView {
                HStack {
                    Text("Favorites")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.favorites) { item in
                            NavigationLink {
                                MovieDetailView(movie: item)
                            } label: {
                                TrendingCard(trendingItem: item)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            
            .frame(maxWidth: .infinity)
            .background(
                Color(red: 39/255, green: 40/255, blue: 59/255)
                    .ignoresSafeArea()
            )
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
