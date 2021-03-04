//
//  PaintDisplayModel+Paint.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/3/21.
//

import Foundation
import Models

extension PaintDisplayModel {
    init(paint: Paint) {
        let color = PHColor(hex: paint.colorHexValue ?? "")!
        self.init(name: paint.name ?? "My Project", brand: paint.brand ?? "Unknown brand", color: color)
    }
}
