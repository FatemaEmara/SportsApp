//
//  FavoritesPresenter.swift
//  SportsApp
//
//  Created by Fatema Emara on 11/05/2026.
//

import Foundation

protocol FavoritesPresenterProtocol {
    var favoritesCount: Int { get }
    func getFavorite(at index: Int) -> FavoriteLeague
    func loadFavorites()
    func deleteFavorite(at index: Int)
    func didSelectLeague(at index: Int)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var view: FavoritesViewProtocol?
    private var favorites: [FavoriteLeague] = []
    private let coreData = CoreDataManager.shared
    
    init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    var favoritesCount: Int {
        return favorites.count
    }
    
    func getFavorite(at index: Int) -> FavoriteLeague {
        return favorites[index]
    }
    
    func loadFavorites() {
        favorites = coreData.fetchLeagues()
        view?.reloadData()
    }
    
    func deleteFavorite(at index: Int) {
        let league = favorites[index]
        coreData.deleteLeague(leagueId: Int(league.leagueId))
        favorites.remove(at: index)
        view?.reloadData()
    }
    
    func didSelectLeague(at index: Int) {
        if NetworkReachability.isConnected() {
            
        } else {
            view?.showNoInternetAlert()
        }
    }
}
