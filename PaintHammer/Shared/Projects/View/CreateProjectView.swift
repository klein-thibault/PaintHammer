//
//  CreateProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/23/21.
//

import Models
import SwiftUI

struct CreateProjectView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @Binding var showAddProjectView: Bool
    @State private var projectName: String = ""
    @State private var selectedImage: PHImage?
    @State private var image: Image?

    @ObservedObject var viewModel: ProjectsListViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Project Name", text: $projectName)

                ImageSelectionView(selectedImage: $selectedImage, image: $image)

                Button("Add Project") {
//                    let project = ProjectDisplayModel(name: projectName, image: selectedImage, steps: [])
//                    viewModel.projects.append(project)
                    let project = Project(context: managedObjectContext)
                    project.name = projectName
                    PersistenceController.shared.save()
                    showAddProjectView = false
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
