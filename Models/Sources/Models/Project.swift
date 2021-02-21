//
//  Project.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation
import UIKit

public struct Project {
    let name: String
    let image: UIImage?
    let steps: [Step]

    public init(name: String, image: UIImage?, steps: [Step]) {
        self.name = name
        self.image = image
        self.steps = steps
    }
}
