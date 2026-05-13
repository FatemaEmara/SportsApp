//
//  LeagueDetailsPresenterProtcol.swift
//  SportsApp
//
//  Created by Eyad waleed on 10/05/2026.
//

import Foundation

protocol LeagueDetailsPresenterProtocol  {

    func getUpcomingEventCount() -> Int
    func getLatestEventCount() -> Int
    func getTeamsCount() -> Int
    func  getView(view :LeagueDetailsViewControllerProtcol)
    func  fetchData(leagueId:Int)
    func  loadUpcomingMatchesCellData(indexPath:Int)-> Event?
    func  loadPlayedMatchesCellData(indexPath:Int)-> Event?
    
    func   loadTeams(indexPath:Int) -> Team?
}
