//
//  FixtureData.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//
import Foundation

protocol FixtureData {
    func fetchUpcomingMatches(leagueId: Int, completion: @escaping ([Event]?) -> Void)

    func fetchLatestMatches(leagueId: Int, completion: @escaping ([Event]?) -> Void)
    func fetchTeamsData(leagueId: Int, completion: @escaping ([Team]?) -> Void)
}

////
////  FixtureData.swift
////  SportsApp
////
////  Created by Eyad waleed on 09/05/2026.
////
//
//import Foundation
//protocol FixtureData{
//    func fetchUpcomingMatches (leagueId:Int)async throws -> [Event]
//    func fetchLiveMatches (leagueId:Int)async throws -> [Event]
//    func fetchLatestMatches (leagueId:Int)async throws -> [Event]
//    func fetchTeamsData (leagueId:Int)async throws -> [Team]
//}
