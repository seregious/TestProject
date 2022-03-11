//
//  TimeView.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 11.03.2022.
//



import SwiftUI


struct TimerView : View {
    let name = "Days withous smoking"
    let image = "lungs"
    let info = "Here is your days without smoke info"
    var body: some View {
        TimeView()
            .modifier(detailedView(maxY: 40, minY: 3, name: name, image: image, info: info))
            .ignoresSafeArea()
    }
}

struct TimeView : View {
    
    
    @State var isTimerOn = false
    @State var selectedDate : Date = Date()
    
    @State var nowDate: Date = Date()
    @AppStorage("date") var referenceDate = Date()
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: isTimerOn) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
        
        if !isTimerOn {
            
            VStack{
                
                Text("Please choose the first day without smoking")
                
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .padding(20)
                    .accentColor(.blue)
                
                Button {
                    isTimerOn = true
                    referenceDate = selectedDate
                } label: {
                    buttonRectangle
                        .overlay(
                            Text("Save")
                                .foregroundColor(.white)
                        )
                }
            }
            .font(.title)
            .padding()
            
            
        } else {
            
            VStack {
                Text("Days without smoking")
                    .font(.title)
                
                
                Circle()
                    .frame(height: 160)
                    .foregroundColor(.blue)
                    .shadow(color: .black, radius: 10, x: 10, y: 10)
                    .overlay(
                        Text(countDownString(from: referenceDate ))
                            .foregroundColor(.white)
                            .scaledToFit()
                            .font(.system(size: 90))
                            .shadow(color: .black, radius: 10, x: 10, y: 10)
                            .onAppear(perform: {
                                _ = self.timer
                            })
                    )
                    .padding(.bottom)
                
                Button {
                    isTimerOn = false
                    referenceDate = Date()
                    selectedDate = Date()
                } label: {
                    buttonRectangle
                        .padding(10)
                        .overlay(
                            Text("Reset")
                                .foregroundColor(.white)
                                .font(.title)
                        )
                }
            }
            
            
        }
    }
    
    var buttonRectangle : some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.blue)
            .frame(height: 50)
            .shadow(color: .black, radius: 10, x: 10, y: 10)
    }
    
    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: referenceDate ,
                            to:  nowDate)
        return String(format: "%01d",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TimerView()
        }
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
