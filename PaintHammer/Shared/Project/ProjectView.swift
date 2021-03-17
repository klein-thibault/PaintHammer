//
//  ProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import Models
import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var project: Project
    @State var showAddStepView = false

    var body: some View {
        List {
            ForEach(project.steps) { step in
                StepView(step: step)
            }
        }
        .navigationTitle(project.name)
        .navigationBarItems(trailing: Button("Add Step") {
            showAddStepView.toggle()
        })
        .sheet(isPresented: $showAddStepView) {
            AddStepView(showAddStepView: $showAddStepView)
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
