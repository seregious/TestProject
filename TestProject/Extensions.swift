//
//  RectangleView.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 10.03.2022.
//

import SwiftUI

struct DataItem: Identifiable {
    let name: String
    let value: Double
    let id = UUID()
    var array = [Double]()
}

struct header: ViewModifier {
    
    private let headerGradient : LinearGradient = LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .bottom, endPoint: .top)
    private let headerHeight = UIScreen.main.bounds.height * 0.25
    
    func body(content: Content) -> some View {
            
            Rectangle()
                .fill(headerGradient)
                .frame(height: headerHeight)
                .overlay(
                    content
                        .foregroundColor(.white)
                )
        .ignoresSafeArea(.all)

    }
}

struct detailedView : ViewModifier {

    let maxY: Double
    let minY: Double
    
    let name, image, info: String

    func body(content: Content) -> some View {
        VStack{
            let averageY = (maxY + minY) / 2
            
            VStack(alignment:.leading) {
                
                Spacer()

                HStack{
                    Image(systemName: image)
                    Text(name)
                    Spacer()
                }
                .font(.largeTitle)
                .padding()
                
                Text(info)
                    .padding()
            }
            .modifier(header())
            
            ScrollView{
            content
                    .frame(height: 300)
            
                
                Item(name: "Minimum", icon: "arrow.down.circle", status: "\(Int(minY))")
                Item(name: "Maximum", icon: "arrow.up.circle", status: "\(Int(maxY))")
                Item(name: "Average", icon: "arrow.forward.circle", status: "\(Int(averageY))")
            }
        }
    }
    
}

struct detailedViewSleep : ViewModifier {

    let deepSleep: Double
    let fastSleep: Double
    let timeInBed: Double
    
    
    let colorDeep : Color
    let colorFast : Color
    let colorBed : Color
    
    let name, image, info: String

    func body(content: Content) -> some View {
        VStack{
            
            VStack(alignment:.leading) {
                
                Spacer()

                HStack{
                    Image(systemName: image)
                    Text(name)
                    Spacer()
                }
                .font(.largeTitle)
                .padding()
                
                Text(info)
                    .padding()
            }
            .modifier(header())
            
            ScrollView{
            content
                    .frame(height: 300)
            
                ItemSleep(name: "Deep Sleep", color: colorDeep, status: "\(deepSleep) h")
                ItemSleep(name: "Fast Sleep", color: colorFast, status: "\(fastSleep) h")
                ItemSleep(name: "Time in Bed", color: colorBed, status: "\(timeInBed) h")
            }
        }
    }
}

    
    
struct ItemSleep : View {
    let name : String
    let color : Color
    let status : String
    var body : some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 1)
            .frame(height: 80)
            .foregroundColor(.gray.opacity(0.4))
            .overlay(
                HStack{
                    rectangle
                    Text(name)
                    
                    Spacer()
                    Text(status)
                }
                    .font(.title2)
                    .padding()
                ,alignment: .leading
            )
            .padding(.horizontal)
    }
    
    var rectangle : some View {
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(color)
                    .frame(width: 20, height: 20)
        }
    
    
}


