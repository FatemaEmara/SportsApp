//
//  APIConfig.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation

struct APIConfig {
    static let apiKey = "d1113cdf7baf6d4cd55315ee017ec6f7fdf04864c8d446f0581ec22186b7a088"
    static let baseURL = "https://apiv2.allsportsapi.com/" + endpoint.rawValue
    static var endpoint =  Sport.football
    
    
}
enum Sport: String ,CaseIterable{
    
    case football = "football/"
    case cricket = "cricket/"
    case tennis = "tennis/"
    case basketball = "basketball/"
}
