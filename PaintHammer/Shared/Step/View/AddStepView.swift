//
//  AddStepView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Combine
import Environment
import Models
import SwiftUI

struct AddStepView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @EnvironmentObject var project: Project
    var viewModel = AddStepViewModel()
    
    @State private var stepDescription: String = ""
    @State private var selectedPaint: Paint?
    @State private var selectedImage: PHImage?
    @Binding var showAddStepView: Bool
    @State var image: Image?

    @State var cancellables = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                TextField("Step description", text: $stepDescription)
                if let selectedPaint = selectedPaint {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint, viewModel: PaintsViewModel())) {
                        PaintView(paint: selectedPaint)
                    }
                } else {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint, viewModel: PaintsViewModel())) {
                        HStack {
                            Image(systemName: "paintbrush.fill")
                            Text("Select a paint")
                        }
                    }
                }

                ImageSelectionView(selectedImage: $selectedImage, image: $image)

                PrimaryButton(title: "Add Step") {
                    viewModel.addStepToProject(projectId: project.id,
                                               description: stepDescription,
                                               image: selectedImage,
                                               paint: selectedPaint)
                        .sink(receiveCompletion: { result in
                            switch result {
                            case .finished:
                                showAddStepView = false

                            case .failure(let error):
                                print(error)
                            }
                        }, receiveValue: { project in
                            self.project.steps = project.steps
                        })
                        .store(in: &cancellables)
                }
                .disabled(stepDescription.isEmpty)

                Spacer()
            }
            .padding()
            .navigationTitle("Add a step")
            .navigationBarItems(trailing: Button("Done") {
                showAddStepView = false
            })
            .onAppear(perform: {
                viewModel.appEnvironment = appEnvironment
            })
        }
    }
}

struct AddStepView_Previews: PreviewProvider {
    @State static var showAddStepView: Bool = true

    static var previews: some View {
        AddStepView(showAddStepView: $showAddStepView)
    }
}
