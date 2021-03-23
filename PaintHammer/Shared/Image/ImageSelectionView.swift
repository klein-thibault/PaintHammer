//
//  ImageSelectionView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/23/21.
//

import Models
import SwiftUI

struct ImageSelectionView: View {
    @State private var showImagePicker = false
    @Binding var selectedImage: PHImage?
    @Binding var image: Image?

    var body: some View {
        Button(action: {
            showImagePicker = true
        }, label: {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            } else {
                Image(uiImage: #imageLiteral(resourceName: "placeholder_image"))
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        })
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePickerView(image: self.$selectedImage)
        }
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct ImageSelectionView_Previews: PreviewProvider {
    @State private static var selectedImage: UIImage?
    @State private static var image: Image?

    static var previews: some View {
        ImageSelectionView(selectedImage: $selectedImage, image: $image)
    }
}
