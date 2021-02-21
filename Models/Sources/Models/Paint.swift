//
//  Paint.swift
//  
//
//  Created by Thibault Klein on 2/20/21.
//

import Foundation
import UIKit

public struct Paint {
    let name: String
    let color: UIColor

    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
