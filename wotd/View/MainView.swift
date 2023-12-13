//
//  MainView.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var timeStamp: Date = .now

    @State var dt: String = ""
    @State var date: String = ""
    
    @State var tf: String = ""
    @State var text: String = "city name to be shown here"
    
    var nm = NetworkManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                
                DatePicker("Date", selection: $timeStamp, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()
                
                Button {
                    print(getDtString(timeStamp))
                } label: {
                    Text("Print dt")
                        .font(.system(size: 15, weight: .bold))
                        .tint(.white)
                        .padding(15)
                        .background(.mint)
                        .clipShape(.buttonBorder)
                }
                
                Text("\(Int(floor(timeStamp.timeIntervalSince1970)))")
                    .padding()
                
                
                TextField("type a city name", text: $tf)
                    .padding()
                
                Text(text)
                    .padding()
                
                Button {
                    text = tf
                    nm.setData(location: text, dt: dt, date: date)
                } label: {
                    Text("Get API data")
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
        .onAppear {
            // 현재 시간을 dt 값에 세팅
            dt = getDtString(timeStamp)
            print(dt)
            date = getDateString(timeStamp)
            print(date)
        }
    }
}

extension MainView {
    func getDtString(_ timeStamp: Date) -> String {
        // Date type인 timestamp를 dt 형태로 변환
        let dt = timeStamp.timeIntervalSince1970
        // 소수점 버리고 Int로 변환
        let dtInteger = Int(floor(dt))
        
        return String(dtInteger)
    }
    
    func getDateString(_ timeStamp: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: timeStamp)
        return date
    }
}

#Preview {
    MainView()
}
