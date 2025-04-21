//
//  ContentView.swift
//  Dex
//
//  Created by Oren Pinkas on 21/04/2025.
//

import SwiftUI

struct PokemonCard: View {
    let pokemon: Pokemon

    var body: some View {

        AsyncImage(url: pokemon.sprite) { image in
            image
        } placeholder: {
            ProgressView()
        }

        VStack(alignment: .leading) {
            
            HStack {
                Text(pokemon.name!.capitalized)
                    .font(.headline)
                if pokemon.favorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }

            HStack {
                ForEach(pokemon.types!, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 13)
                        .padding(.vertical, 5)
                        .background(Color(type.capitalized))
                        .clipShape(.capsule)
                }
            }
        }

    }
}

#Preview {
    
}
