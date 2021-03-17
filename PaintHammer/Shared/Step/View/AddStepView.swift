//
//  AddStepView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

struct AddStepView: View {
    @ObservedObject var viewModel: AddStepViewModel
    
    @State private var stepDescription: String = ""
    @State private var selectedPaint: Paint?
    @State private var selectedImage: UIImage?
    @Binding var showAddStepView: Bool
    @State var image: Image?

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
                    viewModel.addStepToProject(description: stepDescription,
                                               image: nil,
                                               paint: selectedPaint)
                    showAddStepView = false
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
        AddStepView(viewModel: AddStepViewModel(project: Project(id: UUID(), name: "", image: nil, steps: [])),
                    showAddStepView: $showAddStepView)
    }
}
