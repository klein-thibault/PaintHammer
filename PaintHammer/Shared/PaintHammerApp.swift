//
//  PaintHammerApp.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

@main
struct PaintHammerApp: App {
    @Environment(\.scenePhase) var scenePhase

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ProjectsListView(viewModel: ProjectsListViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            // When the app moves to the background, call the save() method to have Core Data saves changes permanently.
            persistenceController.save()
        }
    }
}
