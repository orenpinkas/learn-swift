//
//  ContentView.swift
//  BBQuotes
//
//  Created by Oren Pinkas on 17/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        TabView {
            Tab {
                QuoteView(show: "Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)

            } label: {

                Image(systemName: "tortoise")
                Text("Breaking Bad")

            }

            Tab("Better Call Saul", systemImage: "briefcase") {
                QuoteView(show: "Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }

        }

        .preferredColorScheme(.dark)

    }
}

#Preview {
    ContentView()
}
