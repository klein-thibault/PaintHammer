//
//  PaintCircleColorView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

struct PaintCircleColorView: View {
    var color: PHColor

    var body: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(Color(color))
            .shadow(radius: 2)
    }
}

struct PaintCircleColorView_Previews: PreviewProvider {
    static var previews: some View {
        PaintCircleColorView(color: .red)
    }
}
