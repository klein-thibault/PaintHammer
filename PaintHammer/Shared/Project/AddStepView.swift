//
//  AddStepView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

struct AddStepView: View {
    @State private var stepDescription: String = ""
    @State private var selectedPaint: Paint?
    @State private var selectedImage: UIImage?
    @Binding var showAddStepView: Bool
    @State var image: Image?

    @ObservedObject var project: Project

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 25) {
                TextField("Step description", text: $stepDescription)
                if let selectedPaint = selectedPaint {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint)) {
                        PaintView(paint: selectedPaint)
                    }
                } else {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint)) {
                        Text("Select a paint")
                    }
                }

                ImageSelectionView(selectedImage: $selectedImage, image: $image)

                Button("Add Step") {
                    let step = StepDisplayModel(description: stepDescription, paint: selectedPaint, image: selectedImage)
                    project.steps.append(step)
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

    static var paint: Paint {
        let paint = Paint(context: PersistenceController.shared.container.viewContext)
        paint.name = "Dawnstone"
        paint.brand = "Citadel"
        return paint
    }

    static var step: Step {
        let step = Step(context: PersistenceController.shared.container.viewContext)
        step.name = "Step"
        step.paint = paint
        return step
    }

    static var project: Project {
        let project = Project(context: PersistenceController.shared.container.viewContext)
        project.name = "Imperial Fists"
        project.addToSteps(step)
    }

    static var previews: some View {
        AddStepView(showAddStepView: $showAddStepView, project: project)
    }
}
