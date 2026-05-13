
//
//  TeamsLeaguePresenter.swift
//  SportsApp
//
//  Created by Eyad waleed on 09/05/2026.
//
import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {


    
    
    var upcomingMatches: [Event]?
    var liveMatches: [Event]?
    var playedMatches: [Event]?
    var teams: [Team]?
    weak var view: LeagueDetailsViewControllerProtcol?
    let apiData: FixtureData
    let sport: Sport
    init(apiData: FixtureData, sport: Sport) {
        self.apiData = apiData
        self.sport = sport
    }
    
    func getView(view: LeagueDetailsViewControllerProtcol) {
        self.view = view
    }
    
    func fetchData(leagueId:Int) {
        DispatchQueue.main.async { self.view?.startAnimating() }
        
        let dispatchGroup = DispatchGroup()
        
        // Fetch Upcoming
        dispatchGroup.enter()
        apiData.fetchUpcomingMatches(leagueId: leagueId,sport: sport) { [weak self] result in
            defer { dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.upcomingMatches = events
            case .failure(let error):
               break
               
            }
        }
        
        dispatchGroup.enter()
        apiData.fetchLatestMatches(leagueId: leagueId, sport: sport) { [weak self] result in
            defer { dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.playedMatches = events.filter { event in
                    guard let score = event.eventFinalResult,
                          !score.isEmpty,
                          score.contains(" - ") else { return false }
                    let scores = score.components(separatedBy: " - ")
                    return scores.count == 2 && !scores[0].isEmpty && !scores[1].isEmpty
                }
                
            case .failure(let error):
               break
            }
        }
        
        // Fetch Teams
        dispatchGroup.enter()
        apiData.fetchTeamsData(leagueId: leagueId, sport: sport) { [weak self] result in
            defer { dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                self.teams = teams
            case .failure(let error):
              
               break
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.stopAnimating()
            self.view?.reloadView()

        }
    }
    
    func loadUpcomingMatchesCellData(indexPath: Int) -> Event? {
        guard let matches = upcomingMatches, indexPath < matches.count else {
            return nil
        }
        return matches[indexPath]
    }
    
    func loadPlayedMatchesCellData(indexPath: Int) -> Event? {
        guard let playedMatches = playedMatches, indexPath < playedMatches.count else {
            return nil
        }
        return playedMatches[indexPath]
    }
    
    func loadTeams(indexPath: Int) -> Team? {
        guard let teamsList = self.teams, indexPath < teamsList.count else {
            return nil
        }
        return teamsList[indexPath]
    }
    func getUpcomingEventCount() -> Int {
  

        return self.upcomingMatches?.count ?? 0
    }
    
    func getLatestEventCount() -> Int {
        
        return self.playedMatches?.count ?? 0
    }
    
    func getTeamsCount() -> Int {
        return self.teams?.count ?? 0
    }
    
}



