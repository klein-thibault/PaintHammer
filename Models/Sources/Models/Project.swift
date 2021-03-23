//
//  Project.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public class Project: ObservableObject, Identifiable, Decodable {
    enum CodingKeys: CodingKey {
        case id, name, image, steps
    }

    public let id: UUID
    public let name: String
    public let image: String?
    @Published public var steps: [Step]

    public init(id: UUID, name: String, image: String?, steps: [Step]) {
        self.id = id
        self.name = name
        self.image = image
        self.steps = steps
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try? container.decode(String.self, forKey: .image)
        steps = (try? container.decode([Step].self, forKey: .steps)) ?? []
    }
}
