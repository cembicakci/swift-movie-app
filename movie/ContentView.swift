//
//  ContentView.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if(searchText.isEmpty) {
                    if viewModel.trending.isEmpty {
                        Text("No Results Found")
                            .foregroundColor(.white)
                    } else {
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
                                    TrendingCard(trendingItem: item)
                                }
                            }
                            .padding(.horizontal)
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
                        .background(Color(red: 61/255, green: 61/255, blue: 88/255))
                        .cornerRadius(20)
                        .padding(.horizontal)

                    }

                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Color(red: 39/255, green: 40/255, blue: 59/255)
                    .ignoresSafeArea()
            )
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if newValue.count > 2 {
                Task {
                    await viewModel.search(term: searchText)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTrending()
            }
        }
    }
}



#Preview {
    ContentView()
}
