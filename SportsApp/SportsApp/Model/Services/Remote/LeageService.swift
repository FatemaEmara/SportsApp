//
//  LeageService.swift
//  SportsApp
//
//  Created by Eyad waleed on 13/05/2026.
//

import Foundation
 
class LeagueService {

    func fetchLeagues(
        sport: String,
        completion: @escaping (Result<[League], Error>) -> Void
    ) {


        NetworkService.shared.request(query: .leagues) {
            (response: LeagueResponse?) in

            guard let response = response,
                  response.success == 1 else {

                completion(.failure(SportsError.apiFailed))
                return
            }

            let leagues = response.result

            print("Leagues Count: \(leagues.count)")

            guard !leagues.isEmpty else {
                completion(.failure(SportsError.noData))
                return
            }

            completion(.success(leagues))
        }
    }
}
