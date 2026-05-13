//
//  APIConfig.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation

struct APIConfig {
    static let apiKey = "f067c324326590c4cceb46339a35572e2ce3fbb2389143f3dbbbd88bdbb8eeb7"
    static var endpoint = Sport.football

       static var baseURL: String {
           return "https://apiv2.allsportsapi.com/" + endpoint.rawValue
       }
    
    
}
enum Sport: String ,CaseIterable{
    
    case football = "football/"
    case basketball = "basketball/"
    case tennis = "tennis/"
    case cricket = "cricket/"
    
   
}
