//
//  TestProjectApp.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 07.03.2022.
//

import SwiftUI

@main
struct TestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
            HomeScreenView()
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .accentColor(.white)
        }
    }
}
