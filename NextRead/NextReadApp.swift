//
//  NextReadApp.swift
//  NextRead
//
//  Created by Michael Schmidt on 6/19/23.
//

import SwiftUI

@main
struct NextReadApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
