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

            if let image = step.image, let url = URL(string: image) {
                AsyncImage(url: url, placeholder: { Image("placeholder_image") })
                    .scaledToFit()
                    .shadow(radius: 10)
            }
        }
        .padding()
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        let whiteInk = Paint(id: UUID(), name: "White Ink", brand: "Liquitex", color: .white)
        StepView(step: Step(id: UUID(), description: "Step", paint: whiteInk, image: nil))
    }
}
