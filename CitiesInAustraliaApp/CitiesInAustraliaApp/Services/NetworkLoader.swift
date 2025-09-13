//
//  NetworkLoader.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

protocol NetworkLoader {
    func loadDataFromNetwork() async throws -> [City]
}

final class NetworkCityLoader : NetworkLoader  {
    let url : URL
    private let session : URLSession
    
    init(url: URL = Constants.base_url!,session : URLSession = .shared) {
        self.url = url
        self.session = session
    }
    
    func loadDataFromNetwork() async throws  -> [City] {
        let (data,response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse , (response.statusCode >= 200 && response.statusCode <= 300) else{
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([City].self, from: data)
        
    }
    
    
}
