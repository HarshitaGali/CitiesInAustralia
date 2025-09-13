//
//  CityViewModel.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import Foundation

@MainActor
class CityViewModel : ObservableObject{
    
    @Published private(set) var citiesByState: [String : [City]] = [:]
    @Published var collapsedElements : Set<String> = []
    @Published var isReverded : Bool = false
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = ""
    
    
    private var allcities : [City] = []
    
    private let repository : CityRepository
    
    init(repository : CityRepository){
        self.repository = repository
    }
   
    func storeInitialData() async{
        await loadCityData(didRefresh: false)
    }
    
    func refreshData() async{
        await loadCityData(didRefresh: true)
    }

    private func loadCityData(didRefresh : Bool) async{
        isLoading = true
        errorMessage = nil
        do{
            let cities = try await repository.getCities(didRefresh: didRefresh)
            allcities = cities
            groupCitiesByState(cities: cities)
            
        }catch{
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    private func groupCitiesByState(cities : [City]){
        let groupedStates = Dictionary(grouping: cities, by: { $0.admin_name })
        citiesByState = groupedStates
        
        /* .mapValues{ cities in
         cities.sorted{  (a : City, b : City) in
                 a.city < b.city
                 
             }
            
         } */
    }
    
    private func applyFilterandGroup(){
        var list = allcities
        if isReverded{
            list.reverse()
        }
        groupCitiesByState(cities: list)
        
    }
    
    func toggle(){
        isReverded.toggle()
        applyFilterandGroup()
        
    }
    
    func expandToggle(state : String){
        if collapsedElements.contains(state){
            collapsedElements.remove(state)
        }
        else{
            collapsedElements.insert(state)
        }
    }
    
    var sortedStates: [String] {
       let keys =  citiesByState.keys.sorted()
        return isReverded ? keys.reversed() : keys

        }
}
