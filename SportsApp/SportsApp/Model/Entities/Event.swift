import Foundation

class FixturesResponse: Codable {
    
    let success: Int?
    let result: [Event]?
}

class Event: Codable {
    
    // Match Info
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let eventStatus: String?
    let eventFinalResult: String?
    
    // League Info
    let leagueKey: Int?
    let leagueName: String?
    let countryName: String?
    
    // Home Team
    let homeTeamKey: Int?
    let homeTeamName: String?
    let homeTeamLogo: String?
    
    // Away Team
    let awayTeamKey: Int?
    let awayTeamName: String?
    let awayTeamLogo: String?
    
    // Logos
    let leagueLogo: String?
    let countryLogo: String?
    
    enum CodingKeys: String, CodingKey {
        
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventStatus = "event_status"
        case eventFinalResult = "event_final_result"
        
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
        
        case homeTeamKey = "home_team_key"
        case homeTeamName = "event_home_team"
        case homeTeamLogo = "home_team_logo"
        
        case awayTeamKey = "away_team_key"
        case awayTeamName = "event_away_team"
        case awayTeamLogo = "away_team_logo"
        
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
