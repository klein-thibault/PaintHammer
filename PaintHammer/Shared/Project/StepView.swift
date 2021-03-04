//
//  StepView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import Models
import SwiftUI

struct StepView: View {
    var step: Step

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let paint = step.paint {
                PaintView(paint: paint)
            }

            Text(step.description)

//            if let image = step.image {
//                Image(phImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .shadow(radius: 10)
//            }
        }
        .padding()
    }
}

struct StepView_Previews: PreviewProvider {
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

    static var previews: some View {
        StepView(step: step)
    }
}
