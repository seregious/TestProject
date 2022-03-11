//
//  CircularGraph.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 11.03.2022.
//

import SwiftUI



struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieView : View {
    
    let name = "Sleep time"
    let image = "bed.double"
    let info = "Here is your sleep time info"

    let values = [3.2, 5.1, 1.2]
    let colors = [Color.indigo, Color.green, Color.orange]
    let names = ["Deep Sleep", "Fast Sleep", "Time in bed"]

    

    var body : some View {
        VStack{
            PieChartView(values: values, colors: colors, names: names)
                .modifier(detailedViewSleep(deepSleep: values[0], fastSleep: values[1], timeInBed: values[2], colorDeep: colors[0], colorFast: colors[1], colorBed: colors[2], name: name, image: image, info: info))
                .ignoresSafeArea()
        }
    }
}

struct PieChartView: View {
    let values : [Double]
    let colors : [Color]
    let names : [String]
    
    var backgroundColor: Color = .white
    var innerRadiusFraction: CGFloat = 0.6
    @State var percentage : CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count){ i in
                        PieSliceView(pieSliceData: self.slices[i], percentage: $percentage)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeOut(duration: 1)) {
                                percentage = 1
                            }
                        }
                    }
                    
                    
//                    Circle()
//                        .fill(self.backgroundColor)
//                        .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                    
//                    VStack {
//                        Text("Total")
//                            .font(.title)
//                            .foregroundColor(Color.gray)
//                        Text(String(values.reduce(0, +)))
//                            .font(.title)
//                    }
                }
//                PieChartRows(colors: self.colors, names: self.names, values: self.values.map { String($0) }, percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: self.names[i], color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
}

struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count){ i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[i])
                        .frame(width: 20, height: 20)
                    Text(self.names[i])
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(self.values[i])
                        Text(self.percents[i])
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieView()
    }
}

struct PieSliceView: View {
    var pieSliceData: PieSliceData
    @State var textOpasity : Double = 0
    @Binding var percentage : CGFloat
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .trim(from: 0, to: percentage)
                .fill(pieSliceData.color)
                .shadow(color: .black, radius: 10, x: 10, y: 10)


                
                Text(pieSliceData.text)
                    .position(
                        x: geometry.size.width * 0.45 * CGFloat(1.0 + 0.68 * cos(self.midRadians)),
                        y: geometry.size.height * 0.3 * CGFloat(1.0 - 0.68 * sin(self.midRadians))
                    )
                    .foregroundColor(Color.white)
                    .opacity(textOpasity)
                    .shadow(color: .black, radius: 10, x: 5, y: 5)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeOut(duration: 1)) {
                                textOpasity = 1
                            }
                        }
                    }
            }
        }
        .aspectRatio(0.65, contentMode: .fit)
    }
}
