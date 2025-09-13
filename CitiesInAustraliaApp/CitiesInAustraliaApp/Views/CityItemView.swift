//
//  CityItemView.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import SwiftUI

struct CityItemView: View {
    let city : City
    
    var body: some View {
        HStack{
            VStack{
                Text(city.city)
                    .font(.body)
                if let population = city.population, !population.isEmpty{
                    Text("Population:\(population)")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
            }
            Spacer()
        }
        .padding(.vertical,5)
    }
}

#Preview {
    CityItemView(city: City(city: "Sydney", lat: "", lng: "", country: "Aus", iso2: "", admin_name: "New South Wales", capital: "", population: "4840600", population_proper: ""))
}
