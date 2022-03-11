//
//  RectangleView.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 10.03.2022.
//

import SwiftUI

struct header: ViewModifier {
    
    private let headerGradient : LinearGradient = LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .bottom, endPoint: .top)
    private let headerHeight = UIScreen.main.bounds.height * 0.25
    
    func body(content: Content) -> some View {
        Rectangle()
            .fill(headerGradient)
            .frame(height: headerHeight)
            .overlay(
                content
                    .padding()
                    .foregroundColor(.white)
            )
            .ignoresSafeArea()
            
    }
}
