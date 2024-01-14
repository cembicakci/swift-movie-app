//
//  ContentView.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var viewModel = MovieDiscoverViewModel()
    
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if(searchText.isEmpty) {
                    if viewModel.trending.isEmpty {
                        Text("No Results Found")
                            .foregroundColor(.white)
                    } else {
                        VStack(spacing: 32) {
                            VStack {
                                HStack {
                                    Text("Trending")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.heavy)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.trending) { item in
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
                            
                            VStack {
                                HStack {
                                    Text("Popular")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.heavy)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.popular) { item in
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
                            
                            VStack {
                                HStack {
                                    Text("Upcoming")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.heavy)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.upcoming) { item in
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
                        }
                    }
                } else {
                    LazyVStack() {
                        ForEach(viewModel.searchResults) { item in
                            HStack {
                                AsyncImage(url: item.backdropURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 120)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 120)
                                }
                                .clipped()
                                .cornerRadius(10)
                                
                                VStack() {
                                    Text(item.title)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                        Text("\(item.vote_average, specifier: "%.1f")")
                                        Spacer()
                                    }
                                    .foregroundColor(.yellow)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color(red: 30/255, green: 30/255, blue: 30/255))
                        .cornerRadius(20)
                        .padding(.horizontal)

                    }

                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Color(red: 30/255, green: 30/255, blue: 30/255)
                    .ignoresSafeArea()
            )
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { oldValue, newValue in
            if newValue.count > 1 {
                Task {
                    await viewModel.search(term: searchText)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTrending()
                await viewModel.loadPopular()
                await viewModel.loadUpcoming()
                await viewModel.loadFavourites()
            }
        }
    }
}



#Preview {
    TabView {
        DiscoverView()
            .tabItem {
                Image(systemName: "popcorn")
            }
        
        FavoriteView()
            .tabItem {
                Image(systemName: "heart.fill")
            }
    }
}
