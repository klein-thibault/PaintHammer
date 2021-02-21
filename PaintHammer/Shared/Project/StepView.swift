//
//  StepView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

struct StepView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                Text("Mephiston Red")
            }
            Text("Pre-highlight with Liquitex white ink")
            Image("step_image_example")
                .resizable()
                .scaledToFit()
        }
        .padding()
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView()
    }
}
