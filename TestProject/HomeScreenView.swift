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
        

            VStack(spacing: 0){
                HeaderView(menuState: $menuState)
                
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
    
    var HelthBreif : some View {
        ScrollView{
            VStack(alignment: .leading){
                
                HStack {
                    Text("Health Breif")
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.horizontal)
           
                Item(name: "Heart Rate", icon: "heart", status: "Middle")
                Item(name: "Sleep time", icon: "bed.double", status: "Good")
                Item(name: "Blood Pressure", icon: "waveform.path.ecg", status: "Bad")
                Item(name: "Body mass index", icon: "figure.walk", status: "Middle")
                Item(name: "Weight", icon: "scalemass", status: "Good")
                Item(name: "Cholesterol", icon: "allergens", status: "Middle")
        }
        }
    }
    
    var ReportAnalysis : some View {
        ScrollView{
            HStack {
                Text("Report & Analysis")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)

        }
    }
    
    var RecomendationView : some View {
        ScrollView{
            HStack {
                Text("Recomendation")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)

        }
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
            .frame(height: 100)
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
