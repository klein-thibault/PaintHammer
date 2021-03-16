//
//  Step.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct Step: Identifiable, Decodable {
    public let id: UUID
    public let description: String
    public let paint: Paint?
    public let image: String?

    public init(id: UUID, description: String, paint: Paint?, image: String?) {
        self.id = id
        self.description = description
        self.paint = paint
        self.image = image
    }
}
