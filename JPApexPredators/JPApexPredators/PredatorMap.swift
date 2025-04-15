//
//  Untitled.swift
//  JPApexPredators
//
//  Created by Oren Pinkas on 15/04/2025.
//

import MapKit
import SwiftUI

struct PredatorMap: View {

    @State var position: MapCameraPosition
    @State var satelite: Bool = false
    let predators = Predators().apexPredators

    var body: some View {
        Map(
            position: $position
        ) {
            ForEach(predators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satelite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelite.toggle()
            } label: {
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = Predators().apexPredators[2]
    PredatorMap(
        position: .camera(
            MapCamera(
                centerCoordinate: predator.location,
                distance: 1000,
                heading: 250,
                pitch: 80
            )
        )
    )
}
