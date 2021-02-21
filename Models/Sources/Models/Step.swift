//
//  Step.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct Step {
    let description: String
    let paint: Paint?
    let image: PHImage?

    public init(description: String, paint: Paint?, image: PHImage?) {
        self.description = description
        self.paint = paint
        self.image = image
    }
}
