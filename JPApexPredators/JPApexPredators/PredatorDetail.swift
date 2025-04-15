//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Oren Pinkas on 14/04/2025.
//

import MapKit
import SwiftUI

struct PredatorDetail: View {

    @State var predator: ApexPredator
    @State var position: MapCameraPosition
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .clear, location: 0.8),
                                    Gradient.Stop(color: .black, location: 1),
                                ], startPoint: .top, endPoint: .bottom)
                        }

                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geo.size.width / 1.5,
                            height: geo.size.height / 3.7
                        )
                        .offset(y: 20)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                }

                VStack {
                    Text(predator.name)
                        .font(.largeTitle)

                    NavigationLink {
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
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    } label: {
                        Map(position: $position) {
                            Annotation("", coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .padding(.trailing)

                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(Color.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))

                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)

            }
            .ignoresSafeArea(.all)
            .toolbarBackgroundVisibility(.automatic)
        }
    }
}

#Preview {
    let predator = Predators().apexPredators[2]

    NavigationStack {
        PredatorDetail(
            predator: predator,
            position: .camera(
                MapCamera(centerCoordinate: predator.location, distance: 30000))
        )
        .preferredColorScheme(.dark)
    }
}
