//
//  Step.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation
import UIKit

public struct Step {
    let description: String
    let paint: Paint?
    let image: UIImage?

    public init(description: String, paint: Paint?, image: UIImage?) {
        self.description = description
        self.paint = paint
        self.image = image
    }
}
