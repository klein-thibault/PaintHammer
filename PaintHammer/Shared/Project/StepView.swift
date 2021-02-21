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
        VStack(alignment: .leading, spacing: 10) {
            if let paint = step.paint {
                HStack(spacing: 20) {
                    PaintCircleColorView(color: paint.color)
                    Text(paint.name)
                }
            }

            Text(step.description)

            if let image = step.image {
                Image(phImage: image)
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 10)
            }
        }
        .padding()
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        let whiteInk = Paint(name: "White Ink", brand: "Liquitex", color: .white)
        let image = #imageLiteral(resourceName: "step_image_example")
        StepView(step: Step(description: "Step", paint: whiteInk, image: image))
    }
}
