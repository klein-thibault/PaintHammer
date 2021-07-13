//
//  PaintHammerApp.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import Environment
import SwiftUI

@main
struct PaintHammerApp: App {
    let appEnvironment: AppEnvironment = {
        let appEnvironment = AppEnvironment()
        appEnvironment.backendEnvironmentRaw = BackendEnvironment.local.rawValue
        return appEnvironment
    }()

    var body: some Scene {
        WindowGroup {
            ProjectsListView(viewModel: ProjectsListViewModel())
                .accentColor(Color.primary)
                .environmentObject(appEnvironment)
        }
    }
}
