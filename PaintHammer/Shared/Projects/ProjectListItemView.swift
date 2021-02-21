//
//  ProjectListItemView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

struct ProjectListItemView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("imperial_fists_background")
                .resizable()
                .scaledToFit()
            Text("Project Name")
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
        ProjectListItemView()
    }
}
