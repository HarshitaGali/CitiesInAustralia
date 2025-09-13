//
//  City.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

struct City : Identifiable , Codable  {
    
   /* "city": "Sydney",
    "lat": "-33.8678",
    "lng": "151.2100",
    "country": "Australia",
    "iso2": "AU",
    "admin_name": "New South Wales",
    "capital": "admin",
    "population": "4840600",
    "population_proper": "4840600"
    */
    
let id = UUID()
    let city : String
    let lat : String
    let lng : String
    let country : String
    let iso2 : String
    let admin_name : String
    let capital : String
    let population : String?
    let population_proper : String?
    
    
    enum CodingKeys: String, CodingKey {
        case city, lat, lng, country, iso2, admin_name, capital, population, population_proper
    }
       
    
}
