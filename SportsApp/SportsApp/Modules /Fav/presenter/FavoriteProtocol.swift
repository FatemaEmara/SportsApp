//
//  FavoriteProtocol.swift
//  SportsApp
//
//  Created by Fatema Emara on 11/05/2026.
//

import Foundation
import Foundation

protocol FavoritesViewProtocol: AnyObject {
    func reloadData()
    func showNoInternetAlert()
}

protocol FavoritesPresenterProtocol {
    var favoritesCount: Int { get }
    func getFavorite(at index: Int) -> FavoriteLeague
    func loadFavorites()
    func deleteFavorite(at index: Int)
    func didSelectLeague(at index: Int)
}
