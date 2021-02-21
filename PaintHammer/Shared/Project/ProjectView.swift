//
//  ProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import Models
import SwiftUI

struct ProjectView: View {
    var project: Project

    var body: some View {
        List {
            ForEach(project.steps) { step in
                StepView(step: step)
            }
        }
        .navigationTitle("My Project Name")
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: Project(name: "Imperial Fists",
                                     image: #imageLiteral(resourceName: "imperial_fists_background"),
                                     steps: []))
    }
}
