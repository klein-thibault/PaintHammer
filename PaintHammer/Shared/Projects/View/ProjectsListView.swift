//
//  ProjectsListView.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

struct ProjectsListView: View {
    @ObservedObject var viewModel: ProjectsListViewModel
    @State private var showAddProjectView = false
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [])
    var projects: FetchedResults<Project>

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                ForEach(projects, id: \.self) { project in
                    NavigationLink(destination: ProjectView(project: project)) {
                        ProjectListItemView(project: project)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("PaintHammer")
            .navigationBarItems(trailing: Button("Create Project") {
                showAddProjectView.toggle()
            })
            .sheet(isPresented: $showAddProjectView) {
                CreateProjectView(showAddProjectView: $showAddProjectView, viewModel: viewModel)
            }
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
