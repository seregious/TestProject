//
//  HomeScreenView.swift
//  TestProject
//
//  Created by Сергей Иванчихин on 08.03.2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @State var menuState = 1
        var body: some View {
        
        
        VStack{
            HeaderView(menuState: $menuState)
                
            ScrollView{
            switch menuState {
            case 1:
                HelthBreif
            case 2:
                ReportAnalysis
            case 3:
                RecomendationView
            default:
                HelthBreif
            }
            }
        }
    }
    
    var HelthBreif : some View {
            VStack(alignment: .leading){
                
                HStack {
                    Text("Health Breif")
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.horizontal)
                
                
                NavigationLink {
                    GraphView()
                } label: {
                    Item(name: "Heart Rate", icon: "heart", status: "Middle")
                }
                
                NavigationLink {
                    BarChart()
                } label: {
                    Item(name: "Weight", icon: "scalemass", status: "Good")
                }
                
                NavigationLink {
                    PieView()
                } label: {
                    Item(name: "Sleep time", icon: "bed.double", status: "Good")
                }
                
                NavigationLink {
                    TimerView()
                } label: {
                Item(name: "Days withous smoking", icon: "lungs", status: "Good")
                }
                
                Item(name: "Body mass index", icon: "figure.walk", status: "Middle")
                Item(name: "Cholesterol", icon: "allergens", status: "Middle")
                
        }
        .accentColor(.black)
    }
    
    var ReportAnalysis : some View {
            HStack {
                Text("Report & Analysis")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
    }
    
    var RecomendationView : some View {
            HStack {
                Text("Recomendation")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

struct Item : View {
    
    let name : String
    let icon : String
    let status : String
    var statusColor : Color {
        switch status{
        case "Good" : return Color.green
        case "Middle" : return Color.yellow
        case "Bad" : return Color.red
        default:
            return Color.black
        }
    }
    
    var body: some View{
        RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 1)
            .frame(height: 80)
            .foregroundColor(.gray.opacity(0.4))
            .overlay(
                HStack{
                    Image(systemName: icon)
                    Text(name)
                    
                    Spacer()
                    Text(status)
                        .foregroundColor(statusColor)
                }
                    .font(.title2)
                    .padding()
                ,alignment: .leading
            )
            .padding(.horizontal)
    }
}
