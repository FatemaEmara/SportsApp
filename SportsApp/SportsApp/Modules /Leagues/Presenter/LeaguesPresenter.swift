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
    
    func attachView(_ view: LeaguesViewProtocol) {
        self.view = view
    }
    
    func fetchLeagues(for sport: String) {
        view?.startAnimating()
        NetworkService.fetchLeagues(sportName: sport) { [weak self] response in
            DispatchQueue.main.async {
                self?.view?.stopAnimating()
                if let result = response?.result {
                    self?.leagues = result
                    self?.view?.reloadTable()
                } else {
                    self?.view?.showError("No Internet Connection. Please try again.")
                }
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
