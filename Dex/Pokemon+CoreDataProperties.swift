//
//  Pokemon+CoreDataProperties.swift
//  Dex
//
//  Created by Oren Pinkas on 21/04/2025.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var attack: Int16
    @NSManaged public var defense: Int16
    @NSManaged public var favorite: Bool
    @NSManaged public var hp: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var shiny: URL?
    @NSManaged public var specialAttack: Int16
    @NSManaged public var specialDefense: Int16
    @NSManaged public var speed: Int16
    @NSManaged public var sprite: URL?
    @NSManaged public var types: [String]?

}

extension Pokemon : Identifiable {

}
