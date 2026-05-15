//
//  FixturesDataImp.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//
import Foundation
import Alamofire

class FixturesDataImp: FixtureData {
    
    
    func fetchTeamsData(leagueId: Int, sport: Sport, completion: @escaping ((Result <[Team] , Error>) -> Void)) {
       
        NetworkService.shared.request(query: ApiQuery.teams(leagueId: leagueId)){
            (response : TeamResponse? ) in
            guard let response = response , response.success == 1 else {
                completion(.failure(SportsError.apiFailed))
                return
            }
            guard let result = response.result , !response.result!.isEmpty else {
                completion(.failure(SportsError.noData))
                return
            }
            
            completion(.success(result))
            
        }
        
    }
    
    func fetchUpcomingMatches(
        leagueId: Int, sport: Sport,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let date = self.getTodayAndTomorrow()
        NetworkService.shared.request(query: ApiQuery.upComingMatches(leagueId: leagueId, from: date.today, to: date.tomorrow)) { (response: FixturesResponse?) in
            guard let response = response, response.success == 1 else {
                completion(.failure(SportsError.apiFailed))
                return
            }
            guard let events = response.result, !events.isEmpty else {
                completion(.failure(SportsError.noData))
                return
            }
            completion(.success(events))
        }
    }
    
    func fetchLatestMatches(leagueId: Int, sport: Sport, completion: @escaping ((Result<[Event], Error>) -> Void)) {
         let date = getSixDaysRange()
        NetworkService.shared.request(query: ApiQuery.playedMatches(leagueId: leagueId, from:date.from, to: date.to) ){
            (response: FixturesResponse?) in
            guard let response = response , response.success == 1 else {
                completion(.failure(SportsError.apiFailed))
                return
            }
            guard let result = response.result , !response.result!.isEmpty else {
                completion(.failure(SportsError.noData))
                 return
            }
            completion(.success(result))
            
        }
        
    }
    
    
 
    
    
    
    
    
    
    private func getTodayAndTomorrow() -> (today: String, tomorrow: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        return (
            today: formatter.string(from: today),
            tomorrow: formatter.string(from: tomorrow)
        )
    }
    
    private func getSixDaysRange() -> (from: String, to: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let today = Date()
        let sixDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: today)!
        
        return (
            from: formatter.string(from: sixDaysAgo),
            to: formatter.string(from: today)
        )
    }
}

