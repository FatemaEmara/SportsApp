//
//  NetworkService.swift
//  SportsApp
//
//  Created by Fatema Emara on 08/05/2026.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func fetchLeagues(sportName: String, completion: @escaping (LeagueResponse?) -> Void) {
        let apiKey = "f067c324326590c4cceb46339a35572e2ce3fbb2389143f3dbbbd88bdbb8eeb7"
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(apiKey)"



        AF.request(urlString).responseDecodable(of: LeagueResponse.self) { response in
            print("URL called: \(urlString)")

            switch response.result {
            case .success(let leagueResponse):
                print("Leagues loaded: \(leagueResponse.result.count)")
                completion(leagueResponse)
            case .failure(let error):
                print("Alamofire error: \(error)")
                completion(nil)
            }
        }
    }
    
}
