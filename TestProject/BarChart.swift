//
//  ChartView.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 09.03.2022.
//

import SwiftUI

struct DataItem: Identifiable {
    let name: String
    let value: Double
    let id = UUID()
    
    
}

struct BarChart: View {
    
    let chartData: [DataItem]
    var maxValue: Double
    var minValue: Double
    var averageValue : Double
    
    init(){
        chartData = [
            DataItem(name: "Jan", value: 85),
            DataItem(name: "Feb", value: 79),
            DataItem(name: "Mar", value: 81),
            DataItem(name: "Apr", value: 83),
            DataItem(name: "May", value: 77),
            DataItem(name: "Jun", value: 75),
            DataItem(name: "Jul", value: 71)
        ]
        
        maxValue = chartData.map { $0.value }.max()!
        minValue = chartData.map { $0.value }.min()!
        averageValue = (maxValue + minValue)/2
    }
    
    
    //let emptyArray : [DataItem] = []
    
    var body: some View {
        
        
        VStack{
            
            
            VStack(alignment:.leading) {
                
                
                NavigationLink(destination: HomeScreenView()) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                
                
                
                
                HStack{
                    Image(systemName: "scalemass")
                    Text("Weight")
                    Spacer()
                }
                .font(.largeTitle)
                .padding()
                
                Text("Here is your weight change info")
                    .padding()
            }
            .modifier(header())
            
            ScrollView{
                Chart(data: chartData)
                    .frame(height: 300)
                
                Item(name: "Minimum", icon: "arrow.down.circle", status: "\(Int(minValue))")
                Item(name: "Maximum", icon: "arrow.up.circle", status: "\(Int(maxValue))")
                Item(name: "Average", icon: "arrow.forward.circle", status: "\(Int(averageValue))")
            }
            .ignoresSafeArea()
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChart()
    }
}

struct Chart: View {
    var data: [DataItem]
    
    
    var body: some View {
        GeometryReader { geometry in
            
            let maxValue = data.map { $0.value }.max()!
            let minValue = data.map { $0.value }.min()!
            let averageValue = maxValue - minValue
            let fullBarHeight = geometry.size.height * 0.90
            
            ZStack {
                
                VStack{
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                }
                
                
                VStack {
                    HStack(spacing:0) {
                        ForEach(data) { item in
                            BarView(
                                name: item.name,
                                value: item.value,
                                maxValue: maxValue,
                                minValue: minValue,
                                averageValue: averageValue,
                                fullBarHeight: Double(fullBarHeight))
                            
                        }
                    }
                    .padding(4)
                    
                }
                
            }
        }
    }
}

struct BarView: View {
    var name: String
    var value: Double
    var maxValue: Double
    var minValue: Double
    var averageValue : Double
    var fullBarHeight: Double
    @State var startBarHeight = 0
    
    var body: some View {
        let barHeight = (Double(fullBarHeight) / maxValue) * (value - minValue * 0.9) * 3
        VStack {
            Spacer()
            ZStack {
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius:5.0)
                        .fill(Color.orange)
                        .frame(height: CGFloat(startBarHeight), alignment: .trailing)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: -5)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeOut(duration: 2)) {
                                    startBarHeight = Int(barHeight)
                                }
                            }
                        }
                    
                }
                
                VStack {
                    Spacer()
                    Text("\(value, specifier: "%.0F")")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            Text(name)
        }
        .padding(.horizontal, 4)
    }
}

