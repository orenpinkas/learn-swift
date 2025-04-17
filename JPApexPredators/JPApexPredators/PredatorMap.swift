//
//  Untitled.swift
//  JPApexPredators
//
//  Created by Oren Pinkas on 15/04/2025.
//

import MapKit
import SwiftUI

struct PredatorMap: View {

    let predators = Predators().apexPredators
    
    @State var position: MapCameraPosition
    @State var satelite: Bool = false
    @State private var isPopoverOpen: [ApexPredator.ID] = []
    
    func togglePredatorCard(_ predator: ApexPredator) {
        if isPopoverOpen.contains(predator.id) {
            isPopoverOpen.removeAll { $0 == predator.id }
        } else {
            isPopoverOpen.append(predator.id)
        }
    }
    
    var body: some View {
        Map(
            position: $position
        ) {
            ForEach(predators) { predator in

                Annotation(predator.name, coordinate: predator.location) {
                    ZStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                height: 100
                            )
                            .shadow(color: .white, radius: 3)
                            .scaleEffect(x: -1)
                            .onTapGesture {
                                togglePredatorCard(predator)
                            }
                        if isPopoverOpen.contains(predator.id) {
                            PopoverCard {
                                isPopoverOpen.removeAll { $0 == predator.id }
                            }
                        }
                    }
                }

            }
        }

        .mapStyle(
            satelite
                ? .imagery(elevation: .realistic)
                : .standard(elevation: .realistic)
        )
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelite.toggle()
            } label: {
                Image(
                    systemName: satelite
                        ? "globe.americas.fill" : "globe.americas"
                )
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

struct PopoverCard: View {
    var onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Information")
                .font(.headline)

            Text("This is a helpful popover card with some extra details.")
                .font(.subheadline)

            Button("Got it!", action: onDismiss)
                .padding(.top, 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground))
                .shadow(radius: 10)
        )
        .frame(width: 150)
        .padding(.top, 300)
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
