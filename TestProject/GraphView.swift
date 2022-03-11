//
//  Graph.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 09.03.2022.
//

import SwiftUI

import SwiftUI



struct GraphView: View {
    
    var data : [Double]
    let maxY : Double
    let minY : Double
    let averageY : Double
    
    let image = "heart"
    let name = "Heart rate"
    let info = "Here is your heart rate info"
   
   init () {
       data = [71,83,66,96,102,88,115,77,86,59,63]
       maxY = data.max() ?? 0
       minY = data.min() ?? 0
       averageY = (maxY + minY) / 2
       
   }
    
        
    var body: some View {
        

        Graphic(data: data, maxY: maxY, minY: minY)
            .modifier(detailedView(maxY: maxY, minY: minY, name: name, image: image, info: info))
            .ignoresSafeArea()

}

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}

struct Graphic : View {
     let data : [Double]
     let maxY : Double
     let minY : Double
     let lineColor : Color  = Color.red
    @State  var percentage : CGFloat = 0

    
    var body: some View {
        VStack {
        chartView
            .frame(height: 200)
            .background(chartBackground)
            .overlay(chartYAxis.padding(), alignment: .leading)
            

        }
        .font(.caption)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeOut(duration: 1)) {
                    percentage = 1
                }
            }
        }
    }

     var chartView : some View {
        GeometryReader {geometry in
            Path {path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
        .shadow(color: lineColor, radius: 10, x: 0, y: 10)
        .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
        .shadow(color: lineColor.opacity(0.3), radius: 10, x: 0, y: 30)
        .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
    }
    
    var chartBackground : some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis : some View {
        VStack {
           Text("\(Int(maxY))")
            Spacer()
            Text("\(Int(maxY - minY) / 2)")
            Spacer()
            Text("\(Int(minY))")
        }
    }    
}
}
