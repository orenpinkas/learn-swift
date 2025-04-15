//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Oren Pinkas on 14/04/2025.
//

import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    

}

enum APType: String, Decodable, Identifiable, CaseIterable {
    case all
    case land
    case air
    case sea
    
    var id: APType {self}
    
    var background: Color {
        switch self {
        case .land: .brown
        case .air: .teal
        case .sea: .blue
        case .all: .black
        }
    }
    
    var icon: String {
        switch self {
        case .all: "square.stack.3d.up.fill"
        case .land: "leaf.fill"
        case .air: "wind"
        case .sea: "drop.fill"
        }
    }
}
