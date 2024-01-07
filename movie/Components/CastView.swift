//
//  CastCrew.swift
//  movie
//
//  Created by Cem Bıçakcı on 7.01.2024.
//

import SwiftUI

struct CastView: View {
    
    let cast: MovieCredits.Cast
    
    var body: some View {
        VStack {
            Text(cast.name)
        }
    }
}


