//
//  CityListView.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject private var viewModel : CityViewModel

    init(viewModel: CityViewModel) {
           self.viewModel = viewModel
       }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                PopularPlacesView(places: popularPlaces)
                    .padding(.bottom)
                
                content
                
            }
            .navigationTitle(Constants.navBarTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.toggle()
                        }label : {
                           
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.headline)
                        
                        }
                        .accessibilityLabel("Reverse order")
                    }
                }
                .overlay {
                    if viewModel.isLoading{
                        ProgressView()
                    }
                }
        
            .task{
                await viewModel.storeInitialData()
            }
        }
    }
}
extension CityListView {
    
    private var content : some View {
        Group {
            cityList
        }
    }
    
    private var cityList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12,pinnedViews: .sectionHeaders){
                ForEach(viewModel.sortedStates, id: \.self) { state in
                    Section(header: header(for: state)) {
                        CitiesList(state: state, viewModel: viewModel)
                       
                    }
                }
            }
            
        }
            .listStyle(.insetGrouped)
            .environment(\.defaultMinListHeaderHeight, 0)
            .refreshable {
            await viewModel.refreshData()
            }
        }
    
    struct CitiesList: View {
        let state: String
        @ObservedObject var viewModel: CityViewModel

        var body: some View {
            if viewModel.collapsedElements.contains(state) {
                ForEach(viewModel.citiesByState[state] ?? []) { name in
                    CityItemView(city: name)
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.vertical,2)
                }
            }
               
        }
    
    }
              
    private func header(for state: String) -> some View {
            HStack {
                Text("\(state) (\(viewModel.citiesByState[state]?.count ?? 0))")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .accessibilityIdentifier("state_\(state)")
                Spacer()
                Button {
                    viewModel.expandToggle(state: state)
                } label: {
                    Image(systemName: viewModel.collapsedElements.contains(state) ? "chevron.down" : "chevron.right")
                        .foregroundStyle(Color.secondary)
                }
                
                .buttonStyle(.borderless)
                .accessibilityIdentifier("chevron\(state)")
            }
            .padding(.horizontal)
            .padding(.vertical,2)
            .background(Color(.systemBackground))
        }
                    
    private var loadingOverlay: some View {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.2))
                }
            }
        }
    
}

