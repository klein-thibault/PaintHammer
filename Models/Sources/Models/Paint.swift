//
//  Paint.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct Paint: Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             brand,
             hexColor = "color"
    }

    public let id: UUID
    public let name: String
    public let brand: String
    public let hexColor: String

    public var color: PHColor {
        return PHColor(hexString: hexColor)
    }

    public init(id: UUID, name: String, brand: String, hexColor: String) {
        self.id = id
        self.name = name
        self.brand = brand
        self.hexColor = hexColor
    }

    public init(id: UUID, name: String, brand: String, color: PHColor) {
        self.id = id
        self.name = name
        self.brand = brand
        self.hexColor = color.toHex()!
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        brand = try container.decode(String.self, forKey: .brand)
        hexColor = try container.decode(String.self, forKey: .hexColor)
    }
}
