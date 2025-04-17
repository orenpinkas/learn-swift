//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Oren Pinkas on 14/04/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var filterType = APType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: filterType)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredDinos) { predator in
                    NavigationLink {
                        PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    } label: {
                        HStack {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(color: .white, radius: 1)
                            
                            VStack(alignment: .leading) {
                                Text(predator.name)
                                    .fontWeight(.bold)
                                
                                Text(predator.type.rawValue.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 5)
                                    .background(predator.type.background)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    let predatorsToRemove = indexSet.map {filteredDinos[$0]}
                    predators.remove(predatorsToRemove)
                })
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled(true)
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {alphabetical.toggle()}
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    FilterMenu(filterType: $filterType)
                }
            }
            
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}


