//
//  StepDisplayModel+Init.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/3/21.
//

import Foundation
import Models

extension StepDisplayModel {
    init(step: Step) {
        var paint: PaintDisplayModel?

        if let stepPaint = step.paint {
            paint = PaintDisplayModel(paint: stepPaint)
        }

        self.init(description: step.name ?? "", paint: paint, image: nil)
    }
}
