//
//  SplashScreen.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 13/09/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @StateObject private var viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    
    var body: some View {
        if isActive{
            CityListView(viewModel: viewModel)
        }
        else{
            VStack{
                Color.white.ignoresSafeArea()
                Text("Welcome!!!")
                    .font(.title)
                    
                Image("launchimage")
                    .resizable()
                    .scaledToFit()
                
                    .frame(width: 500,height: 500)
                
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}


