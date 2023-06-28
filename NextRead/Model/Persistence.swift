//
//  Persistence.swift
//  NextRead
//
//  Created by Michael Schmidt on 6/19/23.
//

//
//  Persistence.swift
//  NextRead
//
//  Created by Michael Schmidt on 6/19/23.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "NextRead")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    func saveContext() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Failed to save Core Data context: \(nsError)")
            }
        }
    }
}
