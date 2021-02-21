//
//  Image+PHImage.swift
//  PaintHammer (iOS)
//
//  Created by Thibault Klein on 2/21/21.
//

import Models
import SwiftUI

extension Image {
    init(phImage: PHImage) {
        self.init(uiImage: phImage)
    }
}
