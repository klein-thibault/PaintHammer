//
//  ProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        List {
            StepView()
            StepView()
        }
        .navigationTitle("My Project Name")
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
