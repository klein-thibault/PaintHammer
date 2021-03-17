//
//  PaintView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

struct PaintView: View {
    var paint: Paint

    var body: some View {
        HStack(spacing: 10) {
            PaintCircleColorView(color: paint.color)
            Text(paint.name)
        }
    }
}

struct PaintView_Previews: PreviewProvider {
    static var previews: some View {
        PaintView(paint: Paint(id: UUID(), name: "Dawnstone", brand: "Citadel", color: .gray))
    }
}
