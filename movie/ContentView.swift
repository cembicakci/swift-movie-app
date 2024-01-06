//
//  ContentView.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        ScrollView {
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
        }
        .frame(maxWidth: .infinity)
        .background(
            Color(red: 39/255, green: 40/255, blue: 59/255)
                .ignoresSafeArea()
        )
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
