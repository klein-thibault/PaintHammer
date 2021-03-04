//
//  ProjectDisplayModel+Init.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/3/21.
//

import Foundation
import Models

extension ProjectDisplayModel {
    convenience init(project: Project) {
        let steps = project.stepsArray.map { StepDisplayModel(step: $0) }
        self.init(name: project.name ?? "",
                  image: nil,
                  steps: steps)
    }
}
