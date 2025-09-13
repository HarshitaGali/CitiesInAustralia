//
//  CitiesInAustraliaAppApp.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import SwiftUI

@main
struct CitiesInAustraliaAppApp: App {
    var body: some Scene {
        WindowGroup {
            
            SplashScreen(viewModel: CityViewModel(repository: CityDataRepository(
                networkloader: NetworkCityLoader(),
                dataLoader:DataLoaderFromBundle(),
                cacheLoader: FileCacheService())))
        }
    }
}
