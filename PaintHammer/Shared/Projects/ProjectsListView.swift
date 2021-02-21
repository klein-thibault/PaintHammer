//
//  ProjectsListView.swift
//  Shared
//
//  Created by Thibault Klein on 2/20/21.
//

import SwiftUI

struct ProjectsListView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                NavigationLink(destination: ProjectView()) {
                    ProjectListItemView()
                }
                NavigationLink(destination: ProjectView()) {
                    ProjectListItemView()
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("PaintHammer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProjectsListView()
        }
    }
}
