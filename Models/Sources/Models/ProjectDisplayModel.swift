//
//  ProjectDisplayModel.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public class ProjectDisplayModel: Identifiable, ObservableObject {
    public let id = UUID()
    public let name: String
    public let image: PHImage?
    @Published public var steps: [StepDisplayModel]

    public init(name: String, image: PHImage?, steps: [StepDisplayModel]) {
        self.name = name
        self.image = image
        self.steps = steps
    }
}
