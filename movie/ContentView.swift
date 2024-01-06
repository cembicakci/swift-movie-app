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

struct TrendingCard: View {
    
    let trendingItem: TrendingItem
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 200)
            } placeholder: {
                Rectangle()
                    .fill(Color(red: 61/255, green: 61/255, blue: 88/255))
                    .frame(width: 340, height: 200)
            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer ()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(trendingItem.vote_average, specifier: "%.1f")")
                    Spacer()
                }
                .foregroundColor(.yellow)
            }
            .padding()
            .background(Color(red: 61/255, green: 61/255, blue: 88/255))
        }
        .cornerRadius(10)
    }
}

class MovieDBViewModel: ObservableObject {
    
    @Published var trending: [TrendingItem] = []
    
    private let apiKey = "409d993d44e607bd146c738c9df97a95"
    //static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDlkOTkzZDQ0ZTYwN2JkMTQ2YzczOGM5ZGY5N2E5NSIsInN1YiI6IjYyMDNmYjRkNGRmMjkxMDA2OTFjM2M5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DDE74BuHNhMq6eeElOXjNTkLHaBwPgPZBc_jCHjZXWg"
    
    // https://api.themoviedb.org/3/trending/movie/day?api_key=409d993d44e607bd146c738c9df97a95
    
    func loadTrending() async {
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
            trending = trendingResults.results
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}

struct TrendingResults: Decodable {
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
    
}

struct TrendingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
    let backdrop_path: String
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(backdrop_path)")!
    }
}


#Preview {
    ContentView()
}
