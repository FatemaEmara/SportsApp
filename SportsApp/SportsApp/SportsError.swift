//
//  SportsError.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation
enum SportsError: LocalizedError {
    case apiFailed
    case noData
    case invalidLeagueId
    
    var errorDescription: String? {
        switch self {
        case .apiFailed:
            return "Something went wrong, please try again"
        case .noData:
            return "There is no data"
        case .invalidLeagueId:
            return "Invalid league ID"
        }
    }
}
