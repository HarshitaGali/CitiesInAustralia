//
//  PopularPlacesView.swift
//  CitiesInAustraliaApp
//
//  Created by Harshita Gali on 12/09/2025.
//

import SwiftUI

struct PopularPlacesView: View {
    let places : [Place]
    @State private var index = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $index){
            ForEach(places.indices,id: \.self ){ index in
                Image(places[index].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .tag(index)
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 200)
        .onReceive(timer) { _ in
            withAnimation {
                index = (index + 1) % places.count
            }

        }
       }
       
}
    
#Preview {
    PopularPlacesView(places: [Place(name: "Sydney opera house", imageName: "sydney"),
                               Place(name: "Melbourne", imageName: "melbourne"),
                               Place(name: "Sydney night view", imageName: "nightview")]
    )
}
