//
//  Step.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct Step: Identifiable {
    public let id = UUID()
    public let description: String
    public let paint: Paint?
    public let image: PHImage?

    public init(description: String, paint: Paint?, image: PHImage?) {
        self.description = description
        self.paint = paint
        self.image = image
    }
}
