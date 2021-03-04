//
//  StepDisplayModel.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct StepDisplayModel: Identifiable {
    public let id = UUID()
    public let description: String
    public let paint: PaintDisplayModel?
    public let image: PHImage?

    public init(description: String, paint: PaintDisplayModel?, image: PHImage?) {
        self.description = description
        self.paint = paint
        self.image = image
    }
}
