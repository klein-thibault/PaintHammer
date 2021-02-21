//
//  Project.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct Project: Identifiable {
    public let id = UUID()
    public let name: String
    public let image: PHImage?
    public let steps: [Step]

    public init(name: String, image: PHImage?, steps: [Step]) {
        self.name = name
        self.image = image
        self.steps = steps
    }
}
