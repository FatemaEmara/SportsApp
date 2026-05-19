//
//  Team.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation
class TeamResponse: Codable {
    
    let success: Int?
    let result: [Team]?
}


class Team: Codable {
    
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    
    let players: [Player]?
    let coaches: [Coach]?
    
    enum CodingKeys: String, CodingKey {
        
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        
        case players = "players"
        case coaches = "coaches"
    }
}


struct Player: Codable {
    
    let playerKey: Int?
    let playerImage: String?
    let playerName: String
    let playerNumber: String
    let playerCountry: String
    let playerType: String
    let playerAge: String
    let playerMatchPlayed: String
    let playerGoals: String
    let playerYellowCards: String
    let playerRedCards: String
    let playerInjured: String
    let playerSubstituteOut: String
    let playerSubstitutesOnBench: String
    let playerAssists: String
    let playerBirthdate: String
    let playerIsCaptain: String
    let playerShotsTotal: String
    let playerGoalsConceded: String
    let playerFoulsCommitted: String
    let playerTackles: String
    let playerBlocks: String
    let playerCrossesTotal: String
    let playerInterceptions: String
    let playerClearances: String
    let playerDispossesed: String
    let playerSaves: String
    let playerInsideBoxSaves: String
    let playerDuelsTotal: String
    let playerDuelsWon: String
    let playerDribbleAttempts: String
    let playerDribbleSucc: String
    let playerPenComm: String
    let playerPenWon: String
    let playerPenScored: String
    let playerPenMissed: String
    let playerPasses: String
    let playerPassesAccuracy: String
    let playerKeyPasses: String
    let playerWoordworks: String
    let playerRating: String
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerInjured = "player_injured"
        case playerSubstituteOut = "player_substitute_out"
        case playerSubstitutesOnBench = "player_substitutes_on_bench"
        case playerAssists = "player_assists"
        case playerBirthdate = "player_birthdate"
        case playerIsCaptain = "player_is_captain"
        case playerShotsTotal = "player_shots_total"
        case playerGoalsConceded = "player_goals_conceded"
        case playerFoulsCommitted = "player_fouls_committed"
        case playerTackles = "player_tackles"
        case playerBlocks = "player_blocks"
        case playerCrossesTotal = "player_crosses_total"
        case playerInterceptions = "player_interceptions"
        case playerClearances = "player_clearances"
        case playerDispossesed = "player_dispossesed"
        case playerSaves = "player_saves"
        case playerInsideBoxSaves = "player_inside_box_saves"
        case playerDuelsTotal = "player_duels_total"
        case playerDuelsWon = "player_duels_won"
        case playerDribbleAttempts = "player_dribble_attempts"
        case playerDribbleSucc = "player_dribble_succ"
        case playerPenComm = "player_pen_comm"
        case playerPenWon = "player_pen_won"
        case playerPenScored = "player_pen_scored"
        case playerPenMissed = "player_pen_missed"
        case playerPasses = "player_passes"
        case playerPassesAccuracy = "player_passes_accuracy"
        case playerKeyPasses = "player_key_passes"
        case playerWoordworks = "player_woordworks"
        case playerRating = "player_rating"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        playerKey = try container.decodeIfPresent(Int.self, forKey: .playerKey)
        playerImage = try container.decodeIfPresent(String.self, forKey: .playerImage)
        playerName = try container.decodeIfPresent(String.self, forKey: .playerName) ?? "Unkown"
        playerNumber = try container.decodeIfPresent(String.self, forKey: .playerNumber) ?? ""
        playerCountry = try container.decodeIfPresent(String.self, forKey: .playerCountry) ?? ""
        playerType = try container.decodeIfPresent(String.self, forKey: .playerType) ?? ""
        playerAge = try container.decodeIfPresent(String.self, forKey: .playerAge) ?? "0"
        playerMatchPlayed = try container.decodeIfPresent(String.self, forKey: .playerMatchPlayed) ?? "0"
        playerGoals = try container.decodeIfPresent(String.self, forKey: .playerGoals) ?? "0"
        playerYellowCards = try container.decodeIfPresent(String.self, forKey: .playerYellowCards) ?? "0"
        playerRedCards = try container.decodeIfPresent(String.self, forKey: .playerRedCards) ?? "0"
        playerInjured = try container.decodeIfPresent(String.self, forKey: .playerInjured) ?? "No"
        playerSubstituteOut = try container.decodeIfPresent(String.self, forKey: .playerSubstituteOut) ?? "0"
        playerSubstitutesOnBench = try container.decodeIfPresent(String.self, forKey: .playerSubstitutesOnBench) ?? "0"
        playerAssists = try container.decodeIfPresent(String.self, forKey: .playerAssists) ?? "0"
        playerBirthdate = try container.decodeIfPresent(String.self, forKey: .playerBirthdate) ?? ""
        playerIsCaptain = try container.decodeIfPresent(String.self, forKey: .playerIsCaptain) ?? "0"
        playerShotsTotal = try container.decodeIfPresent(String.self, forKey: .playerShotsTotal) ?? "0"
        playerGoalsConceded = try container.decodeIfPresent(String.self, forKey: .playerGoalsConceded) ?? "0"
        playerFoulsCommitted = try container.decodeIfPresent(String.self, forKey: .playerFoulsCommitted) ?? "0"
        playerTackles = try container.decodeIfPresent(String.self, forKey: .playerTackles) ?? "0"
        playerBlocks = try container.decodeIfPresent(String.self, forKey: .playerBlocks) ?? "0"
        playerCrossesTotal = try container.decodeIfPresent(String.self, forKey: .playerCrossesTotal) ?? "0"
        playerInterceptions = try container.decodeIfPresent(String.self, forKey: .playerInterceptions) ?? "0"
        playerClearances = try container.decodeIfPresent(String.self, forKey: .playerClearances) ?? "0"
        playerDispossesed = try container.decodeIfPresent(String.self, forKey: .playerDispossesed) ?? "0"
        playerSaves = try container.decodeIfPresent(String.self, forKey: .playerSaves) ?? "0"
        playerInsideBoxSaves = try container.decodeIfPresent(String.self, forKey: .playerInsideBoxSaves) ?? "0"
        playerDuelsTotal = try container.decodeIfPresent(String.self, forKey: .playerDuelsTotal) ?? "0"
        playerDuelsWon = try container.decodeIfPresent(String.self, forKey: .playerDuelsWon) ?? "0"
        playerDribbleAttempts = try container.decodeIfPresent(String.self, forKey: .playerDribbleAttempts) ?? "0"
        playerDribbleSucc = try container.decodeIfPresent(String.self, forKey: .playerDribbleSucc) ?? "0"
        playerPenComm = try container.decodeIfPresent(String.self, forKey: .playerPenComm) ?? "0"
        playerPenWon = try container.decodeIfPresent(String.self, forKey: .playerPenWon) ?? "0"
        playerPenScored = try container.decodeIfPresent(String.self, forKey: .playerPenScored) ?? "0"
        playerPenMissed = try container.decodeIfPresent(String.self, forKey: .playerPenMissed) ?? "0"  
        playerPasses = try container.decodeIfPresent(String.self, forKey: .playerPasses) ?? "0"
        playerPassesAccuracy = try container.decodeIfPresent(String.self, forKey: .playerPassesAccuracy) ?? "0"
        playerKeyPasses = try container.decodeIfPresent(String.self, forKey: .playerKeyPasses) ?? "0"
        playerWoordworks = try container.decodeIfPresent(String.self, forKey: .playerWoordworks) ?? ""
        playerRating = try container.decodeIfPresent(String.self, forKey: .playerRating) ?? "0"
    }
}
struct Coach: Codable {
    
    let coachName: String?
    let coachCountry: String?
    let coachAge: String?
    let coachImage: String?
    enum CodingKeys: String, CodingKey {
        
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
        
        case coachImage = "coach_image"
    }
}
