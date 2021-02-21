//
//  ProjectsListView.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

struct ProjectsListView: View {
    @ObservedObject var viewModel: ProjectsListViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                ForEach(viewModel.projects) { project in
                    NavigationLink(destination: ProjectView(project: project)) {
                        ProjectListItemView(project: project)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("PaintHammer")
        }
        .onAppear {
            viewModel.loadProjects()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProjectsListView(viewModel: ProjectsListViewModel())
        }
    }
}
