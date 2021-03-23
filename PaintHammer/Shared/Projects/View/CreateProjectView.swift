//
//  CreateProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/23/21.
//

import Combine
import Models
import SwiftUI

struct CreateProjectView: View {
    @Binding var showAddProjectView: Bool
    @State private var projectName: String = ""
    @State private var selectedImage: PHImage?
    @State private var image: Image?
    @State var cancellabes = Set<AnyCancellable>()

    @ObservedObject var viewModel: ProjectsListViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Project Name", text: $projectName)

                ImageSelectionView(selectedImage: $selectedImage, image: $image)

                Button("Add Project") {
                    viewModel.createProject(name: projectName, image: selectedImage)
                        .sink { result in
                            self.showAddProjectView = false
                        } receiveValue: { projects in
                            viewModel.projects = projects
                        }
                        .store(in: &cancellabes)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Create a new project")
            .navigationBarItems(trailing: Button("Done") {
                showAddProjectView = false
            })
        }
    }
}

struct CreateProjectView_Previews: PreviewProvider {
    @State static var showAddProjectView: Bool = true

    static var previews: some View {
        CreateProjectView(showAddProjectView: $showAddProjectView, viewModel: ProjectsListViewModel())
    }
}
