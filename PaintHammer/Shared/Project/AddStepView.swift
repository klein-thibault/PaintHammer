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
    @Binding var showAddStepView: Bool

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 25) {
                TextField("Description", text: $stepDescription)
                if let selectedPaint = selectedPaint {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint)) {
                        Text(selectedPaint.name)
                        }
                } else {
                    NavigationLink(
                        destination: PaintsView(selectedPaint: $selectedPaint)) {
                        Text("Select a paint")
                        }
                }
                Button("Add Step") {
                    print("Step Added!")
                }
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
