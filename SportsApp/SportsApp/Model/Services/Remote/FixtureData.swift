//
//  FixtureData.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//
import Foundation

protocol FixtureData {
    func fetchUpcomingMatches(leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void)

    func fetchLatestMatches(leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void)
    func fetchTeamsData(leagueId: Int, completion: @escaping (Result<[Team], Error>) -> Void)
}

