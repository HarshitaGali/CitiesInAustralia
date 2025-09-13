//
//  DataLoader.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

protocol DataLoader {
    func loadDataFromJson() -> [City]
}

final class DataLoaderFromBundle : DataLoader {
    
    func loadDataFromJson() -> [City] {
        guard let url = Bundle.main.url(forResource: Constants.jsonFileName, withExtension: "json") else {
            print("JSON file not found")
            return []
            
        }
            do{
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode([City].self, from: data)
                
            } catch{
                print("Failed to load JSON")
                return []
            }
        }
    }

