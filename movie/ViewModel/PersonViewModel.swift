//
//  PersonViewModel.swift
//  movie
//
//  Created by Cem Bıçakcı on 9.01.2024.
//

import Foundation

@MainActor
class PersonViewModel: ObservableObject {
    
    @Published var person: Person?

    func loadPersonDetail(for personId: Int) async {
        
        do {
            let person: Person = try await Network.request(endpoint: "person/\(personId)", responseType: Person.self)
            self.person = person
            
        } catch {
            print(error.localizedDescription)
        }

    }
    
}
