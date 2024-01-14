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
        ScrollView {
            if let person = model.person {
                HStack(spacing: 20) {
                    AsyncImage(url: model.person?.poster) { image in
                        image
                            .image?.resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        Text("Birth Place:")
                            .font(.title3)
                            .fontWeight(.regular)
                        Text(person.place_of_birth)
                    }
                    
                    HStack {
                        Text("Birthday:")
                            .font(.title3)
                            .fontWeight(.regular)
                        Text(person.birthday)
                    }
                    
                    Text("Biography:")
                        .font(.title3)
                    Text(person.biography)
                }
                .navigationTitle(person.name)
                .padding()
            }
            
            Spacer()
        }

        .task {
            await model.loadPersonDetail(for: id)
        }
    }
}

#Preview {
    PersonView(id: 73421)
}
