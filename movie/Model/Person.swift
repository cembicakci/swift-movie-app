//
//  Person.swift
//  movie
//
//  Created by Cem Bıçakcı on 9.01.2024.
//

import Foundation

struct Person: Identifiable, Codable {
    let adult: Bool
    let id: Int
    let biography: String
    let birthday: String
    let name: String
    let place_of_birth: String
    let profile_path: String?
    
    var poster: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseUrl?.appending(path: profile_path ?? "")
    }
    
    static var previewPerson: Person {
        return Person(
            adult: false,
            id: 73421,
            biography: "Joaquin Rafael Phoenix (born October 28, 1974) is an American actor, producer, and animal rights activist. Known for playing dark and unconventional characters in independent film, he is the recipient of various accolades, including an Academy Award, a British Academy Film Award, a Grammy Award, and two Golden Globe Awards. In 2020, he was ranked 12th on the list of the 25 Greatest Actors of the 21st Century by The New York Times. Born in Puerto Rico and raised in Los Angeles and Florida, Phoenix began his career by appearing in television series in the early 1980s with his brother River. His first major film roles were in SpaceCamp (1986) and Parenthood (1989). During this period, he was credited as Leaf Phoenix, a name he gave himself. He took back his birth first name in the early 1990s and received critical acclaim for his supporting roles in the comedy-drama film To Die For (1995) and the period film Quills (2000). Phoenix received further critical acclaim and first Academy Award and Golden Globe Award nominations for Best Actor in a Supporting Role for his portrayal of the evil emperor Commodus in the historical drama film Gladiator (2000). He had success with the horror films Signs (2002) and The Village (2004), the historical drama Hotel Rwanda (2004) and won a Grammy, a Golden Globe and a nomination for the Academy Award for Best Actor for his portrayal of musician Johnny Cash in the biopic Walk the Line (2005). He continued to receive acclaim in two features with his frequent director James Gray; the action thriller We Own the Night (2007) and the romantic drama Two Lovers (2008), before taking a break from acting. In the 2010s, Phoenix returned to acting to critical acclaim. He starred in the psychological drama The Master (2012), winning the Volpi Cup for Best Actor and earning his third Academy Award nomination. He received Golden Globe nominations for his roles in the romantic drama Her (2013) and the crime satire Inherent Vice (2014) and won the Cannes Film Festival Award for Best Actor for his performance in the psychological thriller You Were Never Really Here (2017). Phoenix achieved international stardom and won an Academy Award, a British Academy Film Award, a Screen Actors Guild Award and a second Golden Globe Award for his portrayal of the title character in Joker (2019). Phoenix is an animal rights activist. He has been vegan since the age of three and regularly supports charitable causes and has produced several documentaries on global meat consumption and its impact on the environment. He is in a relationship with actress Rooney Mara, with whom he has a son.",
            birthday: "1974-10-28",
            name: "Joaquin Phoenix",
            place_of_birth: "San Juan, Puerto Rico",
            profile_path: "/dD7hrRueEZmQgGWBp7pAOOt5gLV.jpg"
        )
    }
}
