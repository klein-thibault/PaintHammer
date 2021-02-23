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
    @State private var showImagePicker = false
    @Binding var showAddStepView: Bool

    @ObservedObject var project: Project

    @State var image: Image?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 25) {
                TextField("Description", text: $stepDescription)
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

                Button(action: {
                    showImagePicker = true
                }, label: {
                    if let image = image {
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                    } else {
                        Image(uiImage: #imageLiteral(resourceName: "placeholder_image"))
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                })

                Button("Add Step") {
                    let step = Step(description: stepDescription, paint: selectedPaint, image: selectedImage)
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
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePickerView(image: self.$selectedImage)
            }
        }
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct AddStepView_Previews: PreviewProvider {
    @State static var showAddStepView: Bool = true

    static var previews: some View {
        AddStepView(showAddStepView: $showAddStepView, project: Project(name: "", image: nil, steps: []))
    }
}
