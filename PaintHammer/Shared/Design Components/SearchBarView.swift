//
//  SearchBarView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 7/14/21.
//

import Foundation
import SwiftUI

// https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui
// iOS 15 has a built-in search bar with .searchable()
struct SearchBarView: View {
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color.primary)
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}
