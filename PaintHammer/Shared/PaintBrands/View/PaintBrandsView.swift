//
//  PaintBrandsView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 4/17/21.
//

import Environment
import Models
import SwiftUI

struct PaintBrandsView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: PaintBrandsViewModel
    @Binding var selectedPaint: Paint?
    @Binding var rootIsActive: Bool

    var body: some View {
        List {
            ForEach(viewModel.paintBrands, id: \.self) { paintBrand in
                NavigationLink(
                    destination: PaintsView(viewModel: PaintsViewModel(),
                                            rootIsActive: $rootIsActive,
                                            selectedPaint: $selectedPaint,
                                            paintBrand: paintBrand)
                ) {
                    Text(paintBrand)
                }
                .isDetailLink(false)
            }
            Spacer()
        }
        .padding(.top, 0)
        .navigationTitle("Paint Brands")
        .onAppear {
            viewModel.appEnvironment = appEnvironment
            viewModel.loadAllAvailablePaintBrands()
        }
    }
}

struct PaintBrandsView_Previews: PreviewProvider {
    @State static var selectedPaint: Paint? = nil
    @State static var rootIsActive: Bool = false

    static var previews: some View {
        PaintBrandsView(viewModel: PaintBrandsViewModel(), selectedPaint: $selectedPaint, rootIsActive: $rootIsActive)
    }
}
