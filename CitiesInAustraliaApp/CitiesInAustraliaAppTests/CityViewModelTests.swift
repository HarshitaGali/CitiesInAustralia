//
//  CityViewModelTests.swift
//  CitiesInAustraliaAppTests
//
//  Created by Harshita Gali on 12/09/2025.
//

import XCTest
@testable import CitiesInAustraliaApp

@MainActor
final class CityViewModelTests: XCTestCase {

    var mockRepository : MockCityRepository!
    var viewModel : CityViewModel!
    
    override func setUp()  {
        super.setUp()
        mockRepository = MockCityRepository()
        viewModel = CityViewModel(repository: mockRepository)
    }
    
    override func tearDown(){
        mockRepository = nil
        viewModel = nil
    }
    
    func testLoadInitialData_success() async throws {
        /*{
        "city": "Sydney",
        "lat": "-33.8678",
        "lng": "151.2100",
        "country": "Australia",
        "iso2": "AU",
        "admin_name": "New South Wales",
        "capital": "admin",
        "population": "4840600",
        "population_proper": "4840600"
      },
         {
           "city": "Melbourne",
           "lat": "-37.8142",
           "lng": "144.9631",
           "country": "Australia",
           "iso2": "AU",
           "admin_name": "Victoria",
           "capital": "admin",
           "population": "4529500",
           "population_proper": "4529500"
         },
         "city": "Central Coast",
         "lat": "-33.3000",
         "lng": "151.2000",
         "country": "Australia",
         "iso2": "AU",
         "admin_name": "New South Wales",
         "capital": "",
         "population": "346596",
         "population_proper": "346596"
         
         
         */
        
        mockRepository.cities = [City(city: "Sydney", lat: "-33.8678", lng: "151.2100", country: "Australia", iso2: "AU", admin_name: "New South Wales", capital: "admin", population: "4840600", population_proper: "4840600"),
                                 City(city: "Melbourne", lat: "-37.8142", lng: "144.9631", country: "Australia", iso2: "AU", admin_name: "Victoria", capital: "admin", population: "4529500", population_proper: "4529500")
        
        ]
        
        await viewModel.storeInitialData()
        
        XCTAssertEqual(viewModel.citiesByState["New South Wales"]?.first?.city, "Sydney")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadInitialData_failure() async  {
        mockRepository.error = NSError(domain: "Error", code: 1, userInfo: nil)
        
        await viewModel.storeInitialData()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testToggle_reverseOrder() async {
        
        let city1 = City(city: "Sydney", lat: "-33.8678", lng: "151.2100", country: "Australia", iso2: "AU", admin_name: "New South Wales", capital: "admin", population: "4840600", population_proper: "4840600")
        let city2 = City(city: "Central Coast", lat: "-33.3000", lng: "151.2000", country: "Australia", iso2: "AU", admin_name: "New South Wales", capital: "", population: "346596", population_proper: "346596")
        
        mockRepository.cities = [city1, city2]
        await viewModel.storeInitialData()
        

        guard let initialCities = viewModel.citiesByState["New South Wales"] else {
            XCTFail(" key not found")
            return
        }
        let initialOrder = initialCities.map { $0.city }
        
        
        viewModel.toggle()
        
        
        guard let updatedCities = viewModel.citiesByState["New South Wales"] else {
            XCTFail(" key not found after toggle")
            return
        }
        let reversedOrder = updatedCities.map { $0.city }
        
        XCTAssertEqual(initialOrder.reversed(), reversedOrder)
    }
    
    

    func testExpandAndCollapseState() {
            let state = "New South Wales"
            
            viewModel.expandToggle(state: state)
            XCTAssertTrue(viewModel.collapsedElements.contains(state))
            
            viewModel.expandToggle(state: state)
            XCTAssertFalse(viewModel.collapsedElements.contains(state))
        }
}
