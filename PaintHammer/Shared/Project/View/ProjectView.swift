//
//  ProjectView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import Combine
import Models
import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var project: Project
    @State var showAddStepView = false
    @State var cancellables = Set<AnyCancellable>()

    var viewModel = ProjectViewModel()

    var body: some View {
        List {
            ForEach(project.steps) { step in
                StepView(step: step)
            }
            .onDelete(perform: { indexSet in
                deleteStep(indexSet: indexSet)
            })
        }
        .navigationTitle(project.name)
        .navigationBarItems(trailing: Button("Add Step") {
            showAddStepView.toggle()
        })
        .sheet(isPresented: $showAddStepView) {
            AddStepView(showAddStepView: $showAddStepView)
        }
    }

    private func deleteStep(indexSet: IndexSet) {
        let step = project.steps[indexSet.first!]
        viewModel.deleteStep(step: step, fromProject: project)
            .sink { result in
                switch result {
                case .finished:
                    break

                case .failure(let error):
                    print(error)
                }
            } receiveValue: { project in
                self.project.steps = project.steps
            }
            .store(in: &cancellables)

        project.steps.remove(atOffsets: indexSet)
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
