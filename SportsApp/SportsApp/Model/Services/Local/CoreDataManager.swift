//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Fatema Emara on 11/05/2026.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveLeague(leagueId: Int, leagueName: String, leagueBadge: String, sportName: String ) {
        let entity = FavoriteLeague(context: context)
        entity.leagueId = Int32(leagueId)
        entity.leagueName = leagueName
        entity.leagueBadge = leagueBadge
        entity.sportName = sportName
        try? context.save()
    }
    
    func fetchLeagues() -> [FavoriteLeague] {
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteLeague(leagueId: Int) {
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        request.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        if let result = try? context.fetch(request), let obj = result.first {
            context.delete(obj)
            try? context.save()
        }
    }
    
    func isLeagueFavorite(leagueId: Int) -> Bool {
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        request.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        return ((try? context.fetch(request))?.first) != nil
    }
}
