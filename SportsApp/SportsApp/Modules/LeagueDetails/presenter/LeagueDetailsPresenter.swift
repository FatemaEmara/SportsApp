//
//  TeamsLeaguePresenter.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//

import Foundation
class LeagueDetailsPresenter :LeagueDetailsPresenterProtocol{
    var upcomingMatches : [Event]?
    var liveMatches : [Event]?
    var playedMatches : [Event]?
    var teams : [Team]?
    weak var view:LeagueDetailsViewControllerProtcol?
    let apiData : FixtureData
    init(apiData: FixtureData) {
        self.apiData = apiData
    }
    
    func getView(view: LeagueDetailsViewControllerProtcol) {
        self.view = view
    }
    
    func fetchData() {
  
        Task {
            await MainActor.run { view?.startAnimating() }
            
            do {
      
                
                async let upcoming = apiData.fetchUpcomingMatches(leagueId: 177)

                async let played   = apiData.fetchLatestMatches(leagueId: 177)
                async let teams = apiData.fetchTeamsData(leagueId: 177)
                
          
                
                upcomingMatches = try await upcoming.reversed()
            
  
                playedMatches = try await played.filter { event in
                    guard let result = event.eventFinalResult,
                          !result.isEmpty,
                          result.contains(" - ") else { return false }
                    
                    let scores = result.components(separatedBy: " - ")
                    return scores.count == 2 && !scores[0].isEmpty && !scores[1].isEmpty
                }
          
                self.teams = try await teams
                await MainActor.run { view?.stopAnimating() }
                
            } catch {
            
                await MainActor.run { view?.stopAnimating() }
            }
        }
    }
    func loadUpcomingMatchesCellData(indexPath: Int) -> Event? {
        guard let matches = upcomingMatches, indexPath < matches.count else {
            return nil
        }
        return matches[indexPath]
    }

    func loadPlayedMatchesCellData(indexPath: Int) -> Event? {
        guard let playedMatches = playedMatches else { return  nil}

        let events = playedMatches
        
        return events[indexPath]
    }


    func loadTeams(indexPath:Int) -> Team? {
        guard let teamsList = self.teams , indexPath <  teamsList.count else {
            return nil
        }
        return teamsList[indexPath]
    }
    
    
    
    
    
}

