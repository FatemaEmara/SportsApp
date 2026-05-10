//
//  FixtureQuery.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation
enum FixtureQuery {
    
    case upComingMatches(
        leagueId: Int,
        from: String,
        to: String
    )
    
    case playedMatches(
        leagueId: Int,
        from: String,
        to: String
    )
    
    case liveLeagueMatches(
        leagueId: Int
    )
    case teams(
           leagueId: Int
       )
}

extension FixtureQuery {
    
    var parameters: [String: String] {
        
        switch self {
            
        case .upComingMatches(let leagueId, let from, let to):
            
            return [
                "met": "Fixtures",
                "leagueId": "\(leagueId)",
                "from": from,
                "to": to
            ]
            
            
        case .playedMatches(let leagueId, let from, let to):
            
            return [
                "met": "Fixtures",
                "leagueId": "\(leagueId)",
                "from": from,
                "to": to
            ]
            
            
        case .liveLeagueMatches(let leagueId):
            
            return [
                "met": "Livescore",
                "leagueId": "\(leagueId)"
            ]
        case .teams(let leagueId):
                    
                    return [
                        "met": "Teams",
                        "leagueId": "\(leagueId)"
                    ]
        }
    }
}
