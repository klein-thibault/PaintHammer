//
//  PrimaryButton.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/23/21.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    private let title: String
    private let action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    var body: some View {
        Button(title, action: action)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .accentColor(Color.white)
            .background(Color.primary)
            .cornerRadius(5)
    }
}
