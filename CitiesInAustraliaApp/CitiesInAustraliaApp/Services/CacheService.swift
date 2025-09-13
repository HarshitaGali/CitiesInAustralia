//
//  CacheService.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

protocol CacheService {
    
    func saveCities(cities : [City]) throws
    func loadCities() throws -> [City]?
    func clearCache()
    
}

    final class FileCacheService : CacheService {
        private let userDefaults : UserDefaults
        private let cachedKey : String
       
        
        init(userDefaults: UserDefaults = .standard,cachedKey : String = Constants.cachedKey) {
            self.userDefaults = userDefaults
            self.cachedKey = cachedKey
        }
        
        func saveCities(cities: [City]) throws {
            let data = try JSONEncoder().encode(cities)
            UserDefaults.standard.set(data, forKey: cachedKey)
        }
        
        func loadCities() throws -> [City]? {
            guard let data = UserDefaults.standard.data(forKey: cachedKey) else{ return  nil}
            return try JSONDecoder().decode([City].self, from: data)
            
    }
        
        func clearCache() {
            userDefaults.removeObject(forKey: cachedKey)
        }
}
