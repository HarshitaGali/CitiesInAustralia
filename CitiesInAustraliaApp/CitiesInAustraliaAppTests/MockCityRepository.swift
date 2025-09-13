//
//  MockCityRepository.swift
//  CitiesInAustraliaAppTests
//
//

import Foundation
@testable import CitiesInAustraliaApp

final class MockCityRepository : CityRepository{
    var cities : [City] = []
    var error : Error?
    
    func getCities(didRefresh: Bool) async throws -> [City] {
       if let error = error{
            throw error
        }
        return cities
    }
    
}
