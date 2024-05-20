//
//  iSchoolApp.swift
//  iSchool
//
//  Created by enesozmus on 20.05.2024.
//

import SwiftUI

@main
struct iSchoolApp: App {
    
    // Create an observable instance of the Core Data stack.
    @StateObject private var coreDataStack: CoreDataStack = CoreDataStack.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Inject the persistent container's managed object context
            // into the environment.
                .environment(\.managedObjectContext, coreDataStack.persistentContainer.viewContext)
                .environmentObject(coreDataStack)
        }
    }
}
