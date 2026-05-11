//
//  LeagueDetailsPresenterProtcol.swift
//  SportsApp
//
//  Created by Eyad waleed on 10/05/2026.
//

import Foundation

protocol LeagueDetailsPresenterProtocol  {
    var upcomingMatches: [Event]? { get }
    var playedMatches: [Event]? { get }
    var teams: [Team]? { get }
    
    func  getView(view :LeagueDetailsViewControllerProtcol)
    func  fetchData()
    func  loadUpcomingMatchesCellData(indexPath:Int)-> Event?
    func  loadPlayedMatchesCellData(indexPath:Int)-> Event?
    
    func   loadTeams(indexPath:Int) -> Team?
    
}
