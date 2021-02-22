//
//  ProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import Models
import SwiftUI

struct ProjectView: View {
    @State var showAddStepView = false
    @ObservedObject var project: Project

    var body: some View {
        List {
            ForEach(project.steps) { step in
                StepView(step: step)
            }
        }
        .navigationTitle("My Project Name")
        .navigationBarItems(trailing: Button("Add Step") {
            showAddStepView.toggle()
        })
        .sheet(isPresented: $showAddStepView) {
            AddStepView(showAddStepView: $showAddStepView, project: project)
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        let whiteInk = Paint(name: "White Ink", brand: "Liquitex", color: .white)
        let step = Step(description: "Prime black", paint: whiteInk, image: nil)
        ProjectView(project: Project(name: "Imperial Fists",
                                     image: #imageLiteral(resourceName: "imperial_fists_background"),
                                     steps: [step]))
    }
}
