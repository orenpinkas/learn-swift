//
//  FilterMenu.swift
//  JPApexPredators
//
//  Created by Oren Pinkas on 17/04/2025.
//

import SwiftUI

struct FilterMenu: View {
    @Binding var filterType: APType
    var body: some View {
        Menu {
            Picker("Filter", selection: $filterType.animation()) {
                ForEach(APType.allCases) { type in
                    Label(type.rawValue.capitalized, systemImage: type.icon)
                }
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
}

#Preview {
    @Previewable @State var filterType: APType = .all
    FilterMenu(filterType: $filterType)
}
