//
//  LeagueDetailsPresenterProtcol.swift
//  SportsApp
//
//  Created by Eyad waleed on 10/05/2026.
//

import Foundation

protocol LeagueDetailsPresenterProtocol  {
    func  getView(view :LeagueDetailsViewControllerProtcol)
    func  fetchData()
    func  loadUpcomingMatchesCellData(indexPath:Int)-> Event?
    func  loadPlayedMatchesCellData(indexPath:Int)-> Event?
    
    func   loadTeams(indexPath:Int) -> Team?
}
