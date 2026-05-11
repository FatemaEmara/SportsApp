//
//  FixturesDataImp.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//
import Foundation
import Alamofire

class FixturesDataImp: FixtureData {
    
    // MARK: - Public Methods
    
    func fetchTeamsData(leagueId: Int, completion: @escaping (([Team]?) -> Void)) {
        getTeams(query: FixtureQuery.teams(leagueId: leagueId), completion: completion)
    }
    
    func fetchUpcomingMatches(leagueId: Int, completion: @escaping (([Event]?) -> Void)) {
        let date = getTodayAndTomorrow()
        getFixtures(
            query: FixtureQuery.upComingMatches(leagueId: leagueId, from: date.today, to: date.tomorrow),
            completion: completion
        )
    }
    
    func fetchLatestMatches(leagueId: Int, completion: @escaping (([Event]?) -> Void)) {
        let date = getSixDaysRange()
        print(date.from)
        print(date.to)
        getFixtures(
            query: FixtureQuery.playedMatches(leagueId: leagueId, from: date.from, to: date.to),
            completion: completion
        )
    }
    
    // MARK: - Private Methods
    
    private func getTeams(query: FixtureQuery, completion: @escaping (([Team]?) -> Void)) {
        request(query: query) { (response: TeamResponse?) in
            guard let response = response,
                  response.success == 1,
                  let teams = response.result,
                  !teams.isEmpty else {
                completion(nil)
                return
            }
            completion(teams)
        }
    }
    
    private func getFixtures(query: FixtureQuery, completion: @escaping (([Event]?) -> Void)) {
        request(query: query) { (response: FixturesResponse?) in
            guard let response = response,
                  response.success == 1,
                  let events = response.result,
                  !events.isEmpty else {
                completion(nil)
                return
            }
            completion(events)
        }
    }
    
    private func request<T: Decodable>(query: FixtureQuery, completion: @escaping ((T?) -> Void)) {
        var parameters = query.parameters
        parameters["APIkey"] = APIConfig.apiKey
        
        AF.request(
            APIConfig.baseURL,
            method: .get,
            parameters: parameters
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                DispatchQueue.main.async {
                    completion(value)
                }
            case .failure(let error):
                print("Request failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    // MARK: - Date Helpers
    
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



////
////  FixturesDataImp.swift
////  SportsApp
////
////  Created by Eyad waleed on 09/05/2026.
////
//
//import Foundation
//import Alamofire
//class FixturesDataImp: FixtureData {
//
//
//    func fetchTeamsData(leagueId: Int)async throws -> [Team] {
//        return try await getTeams(query: FixtureQuery.teams(leagueId: leagueId))    }
//
//    func fetchUpcomingMatches(leagueId:Int)async
//    throws -> [Event] {
//        let date = getTodayAndTomorrow()
//
//        return try await getFixtures(query: FixtureQuery.upComingMatches(leagueId: leagueId, from: date.today, to: date.tomorrow))
//
//    }
//
//
//
//    func fetchLatestMatches(leagueId:Int)async throws -> [Event] {
//
//        let date = getSixDaysRange()
//        print(date.from)
//        print(date.to)
//        return try await getFixtures(query: FixtureQuery.playedMatches(leagueId: leagueId, from: date.from, to: date.to ))
//    }
//
//    private func getTeams(query: FixtureQuery)async throws -> [Team] {
//        let response : TeamResponse = try await request(query: query)
//        guard response.success == 1 else {
//            throw SportsError.apiFailed
//        }
//        guard let teams = response.result , !teams.isEmpty else {
//            throw SportsError.noData
//        }
//        return teams
//
//    }
//    private func getFixtures(query: FixtureQuery)async throws -> [Event] {
//        let response :FixturesResponse = try await request(query: query)
//        guard response.success == 1 else {
//            throw SportsError.apiFailed
//        }
//        guard let events = response.result,!events.isEmpty else  {
//            throw SportsError.noData
//        }
//        return events
//
//    }
//
//    private func request<T: Decodable>(query: FixtureQuery)async throws -> T {
//        var parameters = query.parameters
//        parameters["APIkey"] = APIConfig.apiKey
//
//        return try await AF.request(
//            APIConfig.baseUrl,
//            method: .get,
//            parameters: parameters
//        ).serializingDecodable(T.self).value
//    }
//
//
//
//   private func getTodayAndTomorrow() -> (today: String, tomorrow: String) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//
//        let today = Date()
//        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
//
//        return (
//            today: formatter.string(from: today),
//            tomorrow: formatter.string(from: tomorrow)
//        )
//    }
//   private func getSixDaysRange() -> (from: String, to: String) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//
//        let today = Date()
//        let sixDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: today)!
//
//        return (
//            from: formatter.string(from: sixDaysAgo),
//            to: formatter.string(from: today)
//        )
//    }
//
//
//
//
//}
