//
//  movieApp.swift
//  movie
//
//  Created by Cem Bıçakcı on 6.01.2024.
//

import SwiftUI

@main
struct movieApp: App {
    var body: some Scene {
        WindowGroup {
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
    }
}
