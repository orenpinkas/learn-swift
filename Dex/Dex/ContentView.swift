//
//  ContentView.swift
//  Dex
//
//  Created by Oren Pinkas on 21/04/2025.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest<Pokemon>(
        sortDescriptors: []
    ) private var all
    
    @FetchRequest<Pokemon>(
        sortDescriptors: [SortDescriptor(\.id)],
        animation: .default
    ) private var pokedex

    @State private var searchText = ""
    @State private var showFavorites = false

    let fetcher = FetchService()

    private var dynamicPredicate: NSPredicate {
        var predicates: [NSPredicate] = []

        if !searchText.isEmpty {
            let predicate = NSPredicate(
                format: "name CONTAINS[c] %@", searchText)
            predicates.append(predicate)
        }

        if showFavorites {
            let predicate = NSPredicate(format: "favorite == %d", true)
            predicates.append(predicate)
        }

        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }

    var body: some View {
        if all.isEmpty {
            ContentUnavailableView {
                Label("No Pokemon", image: .nopokemon)
            } description: {
                Text("There aren't any Pokemon yet.\nFetch some Pokemon to get started!")
            } actions: {
                Button(
                    "Fetch Pokemon",
                    systemImage: "antenna.radiowaves.left.and.right"
                ) {
                    getPokemon(from: pokedex.count + 1)
                }
                .buttonStyle(.borderedProminent)
            }
        } else {
            NavigationStack {
                List {
                    Section {
                        ForEach(pokedex) { pokemon in
                            NavigationLink {
                                PokemonDetail()
                                    .environmentObject(pokemon)
                            } label: {
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
                                        ForEach(pokemon.types!, id: \.self) {
                                            type in
                                            Text(type.capitalized)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.black)
                                                .padding(.horizontal, 13)
                                                .padding(.vertical, 5)
                                                .background(
                                                    Color(type.capitalized)
                                                )
                                                .clipShape(.capsule)
                                        }
                                    }
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button(pokemon.favorite ? "Remove from Favourites" : "Add to Favourites") {
                                    pokemon.favorite.toggle()
                                    
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        print(error)
                                    }
                                }
                                .tint(pokemon.favorite ? .gray : .yellow)
                            }
                        }

                    } footer: {
                        if all.count < 151 {
                            ContentUnavailableView {
                                Label("Missing Pokemon", image: .nopokemon)
                            } description: {
                                Text(
                                    "The fetch was interrupted!\nFetch the rest of the Pokemon."
                                )
                            } actions: {
                                Button(
                                    "Fetch Pokemon",
                                    systemImage:
                                        "antenna.radiowaves.left.and.right"
                                ) {
                                    getPokemon()
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                }
                .navigationTitle("Pokedex \(pokedex.count)")
                .searchable(text: $searchText, prompt: "Find a Pokemon")
                .autocorrectionDisabled()
                .onChange(of: searchText) {
                    pokedex.nsPredicate = dynamicPredicate
                }
                .onChange(of: showFavorites) {
                    pokedex.nsPredicate = dynamicPredicate
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showFavorites.toggle()
                        } label: {
                            Label(
                                "Filter By Favorites",
                                systemImage: showFavorites
                                    ? "star.fill" : "star")
                        }
                        .tint(.yellow)
                    }
                }

            }
        }


    }

    private func getPokemon(from id: Int = 1) {
        Task {
            for i in id..<152 {
                do {
                    let fetchedPokemon = try await fetcher.fetchPokemon(i)
                    let pokemon = Pokemon(context: viewContext)
                    pokemon.id = fetchedPokemon.id
                    pokemon.name = fetchedPokemon.name
                    pokemon.types = fetchedPokemon.types.map(\.self)
                    pokemon.hp = fetchedPokemon.hp
                    pokemon.attack = fetchedPokemon.attack
                    pokemon.defense = fetchedPokemon.defense
                    pokemon.specialAttack = fetchedPokemon.specialAttack
                    pokemon.specialDefense = fetchedPokemon.specialDefense
                    pokemon.speed = fetchedPokemon.speed
                    pokemon.sprite = fetchedPokemon.sprite
                    pokemon.shiny = fetchedPokemon.shiny

                    try viewContext.save()

                } catch {
                    print(error)
                }
            }
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(
        \.managedObjectContext,
        PersistenceController.preview.container.viewContext)
}
