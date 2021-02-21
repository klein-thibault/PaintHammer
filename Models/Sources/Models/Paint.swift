//
//  Paint.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation

public struct Paint {
    let name: String
    let brand: String
    let color: PHColor

    public init(name: String, brand: String, color: PHColor) {
        self.name = name
        self.brand = brand
        self.color = color
    }
}
