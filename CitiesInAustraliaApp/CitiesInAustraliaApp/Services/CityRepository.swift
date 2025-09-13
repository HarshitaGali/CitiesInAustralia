//
//  CityRepository.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

protocol CityRepository{
    func getCities(didRefresh : Bool) async throws -> [City]
}

final class CityDataRepository : CityRepository{
    private let networkloader : NetworkLoader
    private let dataLoader : DataLoader
    private let cacheLoader : CacheService
    
    init(networkloader: NetworkLoader, dataLoader: DataLoader, cacheLoader: CacheService) {
        self.networkloader = networkloader
        self.dataLoader = dataLoader
        self.cacheLoader = cacheLoader
    }
    
    func getCities(didRefresh : Bool) async throws -> [City]{
        
        if !didRefresh,let cached = try? cacheLoader.loadCities(){
            return cached
        }
        
        do{
            let cities = try await networkloader.loadDataFromNetwork()
            try cacheLoader.saveCities(cities: cities)
            return cities
            
        } catch {
            let cities = dataLoader.loadDataFromJson()
                   try? cacheLoader.saveCities(cities: cities)
                   return cities
           }
            
        }
    }

