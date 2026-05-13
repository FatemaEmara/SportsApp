//
//  FixtureQuery.swift
//  SportsApp
//

import Foundation

enum ApiQuery {
    
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
    
    case leagues
}

extension ApiQuery {
    
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
            
            
        case .leagues:
            
            return [
                "met": "Leagues"
            ]
        }
    }
}
