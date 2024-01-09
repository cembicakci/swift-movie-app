//
//  PersonView.swift
//  movie
//
//  Created by Cem Bıçakcı on 9.01.2024.
//

import SwiftUI

struct PersonView: View {
    
    @StateObject var model = PersonViewModel()
    
    let id: Int

    var body: some View {
        VStack {
            if let person = model.person {
                Text(person.name)
                Text(person.birthday)
            }
        }
        .task {
            await model.loadPersonDetail(for: id)
        }
    }
}

#Preview {
    PersonView(id: 73421)
}
