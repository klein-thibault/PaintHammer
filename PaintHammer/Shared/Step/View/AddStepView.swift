//
//  AddStepView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Combine
import Models
import SwiftUI

struct AddStepView: View {
    @EnvironmentObject var project: Project
    var viewModel = AddStepViewModel()
    
    @State private var stepDescription: String = ""
    @State private var selectedPaint: Paint?
    @State private var selectedImage: UIImage?
    @Binding var showAddStepView: Bool
    @State var image: Image?

    @State var cancellables = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 25) {
                TextField("Step description", text: $stepDescription)
                if let selectedPaint = selectedPaint {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint, viewModel: PaintsViewModel())) {
                        PaintView(paint: selectedPaint)
                    }
                } else {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint, viewModel: PaintsViewModel())) {
                        Text("Select a paint")
                    }
                }

                ImageSelectionView(selectedImage: $selectedImage, image: $image)

                Button("Add Step") {
                    viewModel.addStepToProject(projectId: project.id,
                                               description: stepDescription,
                                               image: nil,
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
        }
    }
}

struct AddStepView_Previews: PreviewProvider {
    @State static var showAddStepView: Bool = true

    static var previews: some View {
        AddStepView(showAddStepView: $showAddStepView)
    }
}
