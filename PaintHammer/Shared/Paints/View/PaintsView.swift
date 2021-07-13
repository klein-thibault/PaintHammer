//
//  PaintsView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Environment
import Models
import SwiftUI

struct PaintsView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: PaintsViewModel

    @Binding var rootIsActive: Bool
    @Binding var selectedPaint: Paint?

    @State private var selectedPaintBrand = 0

    let paintBrand: String

    var body: some View {
        List {
            ForEach(viewModel.paints) { paint in
                Button(action: {
                    selectedPaint = paint
                    // Pop back to the add step view
                    rootIsActive = false
                }, label: {
                    PaintView(paint: paint)
                })
            }
        }
        .padding(.top, 0)
        .navigationTitle(paintBrand)
        .onAppear {
            viewModel.appEnvironment = appEnvironment
            viewModel.loadPaintsForBrand(paintBrand)
        }
    }
}

struct PaintsView_Previews: PreviewProvider {
    @State static var selectedPaint: Paint? = nil
    @State static var rootIsActive: Bool = false

    static var previews: some View {
        PaintsView(viewModel: PaintsViewModel(),
                   rootIsActive: $rootIsActive,
                   selectedPaint: $selectedPaint,
                   paintBrand: "Citadel")
    }
}
