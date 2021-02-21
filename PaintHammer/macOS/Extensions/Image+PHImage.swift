//
//  Image+PHImage.swift
//  PaintHammer (macOS)
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

extension Image {
    init(phImage: PHImage) {
        self.init(nsImage: phImage)
    }
}

