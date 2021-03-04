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
            PaintCircleColorView(color: paint.colorWrapped)
            Text(paint.nameWrapped)
        }
    }
}

struct PaintView_Previews: PreviewProvider {
    static var paint: Paint {
        let paint = Paint(context: PersistenceController.shared.container.viewContext)
        paint.name = "Dawnstone"
        paint.brand = "Citadel"
        return paint
    }

    static var previews: some View {
        PaintView(paint: paint)
    }
}
