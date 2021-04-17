//
//  ProjectsListView.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import Environment
import SwiftUI

struct ProjectsListView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: ProjectsListViewModel
    @State private var showAddProjectView = false
    @State private var showLoginView = false

    var navigationBarItemLeadingButton: some View {
        if appEnvironment.isLoggedIn {
            return Button("Logout") {
                appEnvironment.authToken = ""
                viewModel.clearProjects()
            }
        } else {
            return Button("Login") {
                showLoginView.toggle()
            }
        }
    }

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
            .navigationBarItems(leading: navigationBarItemLeadingButton,
                                trailing: Group {
                                    if appEnvironment.isLoggedIn {
                                        Button("Create Project") {
                                            showAddProjectView.toggle()
                                        }
                                    }
                                }
            )
            .sheet(isPresented: $showLoginView) {
                LoginView(showLoginView: $showLoginView, viewModel: LoginViewModel())
            }
            .sheet(isPresented: $showAddProjectView) {
                CreateProjectView(showAddProjectView: $showAddProjectView, viewModel: viewModel)
                    .accentColor(Color.primary)
            }
            .onAppear {
                viewModel.appEnvironment = appEnvironment
                viewModel.loadProjects()
            }
            .onChange(of: showLoginView, perform: { value in
                if !showLoginView {
                    viewModel.loadProjects()
                }
            })
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
