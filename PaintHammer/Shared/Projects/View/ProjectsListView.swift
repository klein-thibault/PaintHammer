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

    init(viewModel: ProjectsListViewModel) {
        UITableView.appearance().backgroundColor = .clear
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.projects) { project in
                    NavigationLink(destination: ProjectView().environmentObject(project)) {
                        ProjectListItemView(project: project)
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteProject(indexSet: indexSet)
                })

                Spacer()
            }
            .navigationTitle("PaintHammer")
            .navigationBarItems(trailing: Button("Create Project") {
                showAddProjectView.toggle()
            })
            .sheet(isPresented: $showAddProjectView) {
                CreateProjectView(showAddProjectView: $showAddProjectView, viewModel: viewModel)
                    .accentColor(Color.primary)
            }
            .onAppear {
                viewModel.loadProjects()
            }
        }
    }

    private func deleteProject(indexSet: IndexSet) {
        let index = indexSet.first!
        let project = viewModel.projects[index]
        viewModel.deleteProject(project, atIndex: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProjectsListView(viewModel: ProjectsListViewModel())
        }
    }
}
