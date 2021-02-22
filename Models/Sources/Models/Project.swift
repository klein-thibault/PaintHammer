//
//  Project.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public class Project: Identifiable, ObservableObject {
    public let id = UUID()
    public let name: String
    public let image: PHImage?
    @Published public var steps: [Step]

    public init(name: String, image: PHImage?, steps: [Step]) {
        self.name = name
        self.image = image
        self.steps = steps
    }
}
