//
//  MainView.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var timeStamp: Date = .now
    
    var x: String = "127.454499829132"
    var y: String = "36.7423562993671"
    @State var dt: String = ""
    
    
    
    var nt = NetworkManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Date", selection: $timeStamp, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()
                
                Button {
                    print(timeStamp.timeIntervalSince1970)
                    print(type(of: timeStamp.timeIntervalSince1970))
                    print(Int(floor(timeStamp.timeIntervalSince1970)))
                    self.dt = String(Int(floor(timeStamp.timeIntervalSince1970)))
                } label: {
                    Text("Print dt")
                        .font(.system(size: 15, weight: .bold))
                        .tint(.white)
                        .padding(15)
                        .background(.mint)
                        .clipShape(.buttonBorder)
                }
                
                Text("\(timeStamp.timeIntervalSince1970)")
                    .padding()
                
                Spacer()
                
                Button {
                    nt.getOpenWeather(x: x, y: y, dt: dt)
                    
                } label: {
                    Text("GET OpenWeather API")
                        .font(.system(size: 15, weight: .bold))
                        .tint(.white)
                        .padding(15)
                        .background(.mint)
                        .clipShape(.buttonBorder)
                }
                .padding()
                
                Button {
                    nt.getKakao(location: "청주시 오창읍")
                } label: {
                    Text("GET KakaoMap API")
                        .font(.system(size: 15, weight: .bold))
                        .tint(.white)
                        .padding(15)
                        .background(.mint)
                        .clipShape(.buttonBorder)
                }
                .padding()
                
                Spacer()

            }
            .navigationTitle("wotd")
        }
    }
}

#Preview {
    MainView()
}
