//
//  AsyncImage.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/15/21.
//

import Foundation
import SwiftUI

// https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/
struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image).resizable()
            } else {
                placeholder
            }
        }
        .onAppear(perform: loader.load)
    }
}
