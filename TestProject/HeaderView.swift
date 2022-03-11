//
//  ContentView.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 07.03.2022.
//

import SwiftUI

struct HeaderView: View {
    
    private let headerWidth = UIScreen.main.bounds.width * 0.14
    @State var capsulePadding : CGFloat = 0
    
    @Binding var menuState : Int
    
    
    
    var body: some View {

        headerInfo
            .modifier(header())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(menuState: .constant(1))
    }
}

extension HeaderView {
    
    private var headerInfo : some View {
        VStack(alignment: .leading){

            profileInfo
            menuButtons
            
            Capsule(style: .continuous)
                .frame(width: UIScreen.main.bounds.width * 0.33, height: 8)
                .padding(.leading, capsulePadding)
        }
        .foregroundColor(.white)

    }
    
    private var menuButtons : some View {
        VStack {
            HStack {
                
                Image(systemName: "house")
                    .padding(.horizontal, headerWidth)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            menuState = 1
                            capsulePadding = UIScreen.main.bounds.width * 0
                        }
                    }
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .padding(.horizontal, headerWidth)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            menuState = 2
                            capsulePadding = UIScreen.main.bounds.width * 0.37
                        }                    }
                
                Image(systemName: "cross.case")
                    .padding(.horizontal, headerWidth)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            menuState = 3
                            capsulePadding = UIScreen.main.bounds.width * 0.72
                        }                    }
                
            }
            .font(.title2)
        }
    }
    
    private var profilePhoto : some View {
        ZStack {
            Circle()
                
            Image(systemName: "person.crop.circle")
                .resizable()
                .foregroundColor(.blue)
                .padding(3)
                .scaledToFit()
        }
        .frame(width: 70)
    }
    
    private var profileInfo : some View {
        HStack{
            
            profilePhoto
            
            VStack {
                HStack{
                Text("Name")
                    .font(.title3)
                    
                    Image(systemName: "seal.fill")

                }
                .padding(3)
                    
                HStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .frame(width: 180, height: 20)
                        .overlay(
                            HStack {
                                Image(systemName: "gobackward")
                        Text("Last updated 11 Sep, 2021")
                            
                            }
                                .font(.caption)
                    )
                }
            }
            Spacer()
            Image(systemName: "ellipsis")
        }
        .padding(.leading, 30)
    }
}
