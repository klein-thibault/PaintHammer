//
//  ProjectListItemView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import Models
import SwiftUI

struct ProjectListItemView: View {
    var project: Project

    var body: some View {
        ZStack(alignment: .bottom) {
            if let image = project.image, let url = URL(string: image) {
                AsyncImage(url: url, placeholder: { Image("placeholder_image") })
                    .scaledToFit()
                    .clipped()
            }

            Text(project.name)
                .font(.title)
                .padding(20)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color.black.opacity(0.7))
        }
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct ProjectListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let project = Project(id: UUID(),
                              name: "Imperial Fists",
                              image: nil,
                              steps: [])
        ProjectListItemView(project: project)
    }
}
