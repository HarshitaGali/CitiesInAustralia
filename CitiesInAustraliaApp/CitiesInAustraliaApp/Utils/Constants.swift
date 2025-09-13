//
//  Constants.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

enum Constants {
    static let jsonFileName = "au_cities"
    static let base_url = URL(string: "https://www.australia.com/cities")
    static let cachedKey = "catchedCities"
    static let cacheTimeInterval: TimeInterval = 60 * 60 * 24
    static let navBarTitle = "Cities of Australia"

}

let popularPlaces : [Place] = [
    Place(name: "Sydney opera house", imageName: "sydneynew"),
    Place(name: "Melbourne", imageName: "melbourne"),
    Place(name: "Sydney night view", imageName: "nightview"),
    Place(name: "bridge", imageName: "bridgeaus"),
    Place(name: "QueensLAnd", imageName: "queensland")
    ]
