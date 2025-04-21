//
//  Persistence.swift
//  Dex
//
//  Created by Oren Pinkas on 21/04/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var previewPokemon: Pokemon {
        let context = PersistenceController.preview.container.viewContext
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        guard let previewPokemon = try? context.fetch(fetchRequest).first else {
            fatalError("Failed to fetch preview Pokemon")
        }
        return previewPokemon
    }
    
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newItem = Pokemon(context: viewContext)
        newItem.id = 1
        newItem.name = "bulbabababababa"
        newItem.types = ["grass", "poison"]
        newItem.hp = 45
        newItem.attack = 49
        newItem.defense = 49
        newItem.specialAttack = 65
        newItem.specialDefense = 65
        newItem.speed = 45
        newItem.sprite = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        newItem.shiny = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Dex")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
