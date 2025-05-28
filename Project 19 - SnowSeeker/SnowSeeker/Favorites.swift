//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Harshit Singh on 5/27/25.
//

import SwiftUI

@Observable
class Favorites {
    static let favoriteUDKey = "FavoritesUserDefaultsKey"
    
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"

    init() {
        if let object = UserDefaults.standard.value(forKey: Favorites.favoriteUDKey) as? [String] {
            resorts = Set(object)
        } else {
            resorts = []
        }
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: Favorites.favoriteUDKey)
    }
}
