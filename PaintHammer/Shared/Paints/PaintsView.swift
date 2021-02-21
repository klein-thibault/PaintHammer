//
//  PaintsView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

struct PaintsView: View {
    @State private var selectedPaintBrand = 0
    @Binding var selectedPaint: Paint?
    var paintBrands = ["Citadel", "Vallejo", "AK"]
    var availablePaints = [
        "Citadel": [
            Paint(name: "Mephiston Red", brand: "Citadel", color: .red),
            Paint(name: "Dawnstone", brand: "Citadel", color: .gray)
        ]
    ]

    var body: some View {
        VStack {
            Picker(selection: $selectedPaintBrand, label: Text("Paint Brand")) {
                ForEach(0..<paintBrands.count) {
                    Text(paintBrands[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            List {
                let selectedBrand = paintBrands[selectedPaintBrand]
                if let selectedPaints = availablePaints[selectedBrand] {
                    ForEach(selectedPaints) { paint in
                        HStack {
                            PaintCircleColorView(color: paint.color)
                            Text(paint.name)
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}

struct PaintsView_Previews: PreviewProvider {
    @State static var selectedPaint: Paint? = nil

    static var previews: some View {
        PaintsView(selectedPaint: $selectedPaint)
    }
}
