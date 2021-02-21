//
//  ProjectsListViewModel.swift
//  PaintHammer
//
//  Created by Thibault Klein on 2/21/21.
//

import Foundation
import Models

final class ProjectsListViewModel: ObservableObject {
    @Published private(set) var projects: [Project] = []

    func loadProjects() {
        let whiteInk = Paint(name: "White Ink", brand: "Liquitex", color: .white)
        let blackPrimer = Paint(name: "Primer", brand: "Vallejo", color: .black)
        let project1 = Project(name: "Imperial Fists",
                               image: #imageLiteral(resourceName: "imperial_fists_background"),
                               steps: [
                                Step(description: "Prime black", paint: blackPrimer, image: nil),
                                Step(description: "Pre-highlight", paint: whiteInk, image: nil)
                               ])
        self.projects = [project1]
    }
}
