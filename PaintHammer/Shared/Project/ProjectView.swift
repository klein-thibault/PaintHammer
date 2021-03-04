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
            ForEach(project.stepsArray) { step in
                StepView(step: step)
            }
        }
        .navigationTitle(project.nameWrapped)
        .navigationBarItems(trailing: Button("Add Step") {
            showAddStepView.toggle()
        })
        .sheet(isPresented: $showAddStepView) {
            AddStepView(showAddStepView: $showAddStepView, project: project)
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
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
        ProjectView(project: project)
    }
}
