//
//  PaintHammerApp.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

@main
struct PaintHammerApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectsListView(viewModel: ProjectsListViewModel())
        }
    }
}
