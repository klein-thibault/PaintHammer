//
//  ImageLoader.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/15/21.
//

import Combine
import Foundation
import Models
import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: PHImage?
    private let url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }

    func load() {
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
