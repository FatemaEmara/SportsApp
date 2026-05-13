//
//  FixtureData.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation
protocol FixtureData{
    func fetchUpcomingMatches (leagueId:Int) async throws -> [Event]
    func fetchLatestMatches (leagueId:Int) async throws -> [Event]
    func fetchTeamsData (leagueId:Int) async throws -> [Team]
}
