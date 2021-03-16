//
//  Project.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public class Project: Identifiable, Decodable {
    public let id: UUID
    public let name: String
    public let image: String?
    public var steps: [Step]

    public init(id: UUID, name: String, image: String?, steps: [Step]) {
        self.id = id
        self.name = name
        self.image = image
        self.steps = steps
    }
}
