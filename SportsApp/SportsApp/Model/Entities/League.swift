//
//  League.swift
//  SportsApp
//
//  Created by Fatema Emara on 08/05/2026.
//

import Foundation
struct LeagueResponse: Decodable {
    var success: Int  
    var result: [League]
}

struct League: Decodable {
    var league_key: Int?
    var league_name: String?
    var country_key: Int?
    var country_name: String?
    var league_logo: String?
    var country_logo: String?
}
