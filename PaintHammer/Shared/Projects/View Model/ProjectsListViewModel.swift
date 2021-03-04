//
//  ProjectsListViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Foundation
import Models
import SwiftUI

final class ProjectsListViewModel: ObservableObject {
    @Published var projects: [ProjectDisplayModel] = []

    func loadProjects(projects: FetchedResults<Project>) {
        for project in projects {
            let displayProject = ProjectDisplayModel(project: project)
            self.projects.append(displayProject)
        }
    }
}
