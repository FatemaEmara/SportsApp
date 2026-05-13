//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by Fatema Emara on 08/05/2026.
//

import Foundation

protocol LeaguesPresenterProtocol {
    func attachView(_ view: LeaguesViewProtocol)
    func fetchLeagues(for sport: String)
    func getItemsCount() -> Int
    func getLeague(at index: Int) -> League
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    private var leagues: [League] = []
    weak var view: LeaguesViewProtocol?
    var apiResponse : LeagueService!
    func attachView(_ view: LeaguesViewProtocol) {
        self.view = view
        self.apiResponse = LeagueService()
    }
    
    func fetchLeagues(for sport: String) {
        view?.startAnimating()
        apiResponse.fetchLeagues(sport: sport) { [weak self] response in
            switch response {
            case .success(let leagues ) :
                DispatchQueue.main.async {
                    self?.view?.stopAnimating()
                        self?.leagues = leagues
                        self?.view?.reloadTable()
                    print("The leagues count \(leagues.count)")
                    }
                
            case .failure(let error):
                print(error)
            
            
            }
        }
    }
    
    func getItemsCount() -> Int {
        return leagues.count
    }
    
    func getLeague(at index: Int) -> League {
        return leagues[index]
    }
}
