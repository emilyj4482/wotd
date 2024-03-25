//
//  AddSheet.swift
//  wotd
//
//  Created by EMILY on 14/03/2024.
//

import SwiftUI

struct AddSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var sm = SearchManager.shared
    
    @State var city: String = ""
    @State var date: Date = .now
    
    @State private var tapped: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 50) {
                    Text("Date")
                    
                    DatePicker(selection: $date, displayedComponents: .date) {}
                        .datePickerStyle(.compact)
                        .frame(width: 104)
                }
                
                HStack(spacing: 50) {
                    Text("City")
                    
                    TextField("Enter a city name.", text: $city)
                    
                    if !city.isEmpty {
                        Button {
                            city = ""
                            sm.cities = []
                            tapped = false
                        } label: {
                            Image(systemName: "x.circle.fill")
                        }
                        .tint(.gray.opacity(0.4))
                        .padding(.trailing, 16)
                    }
                }
                
                List(sm.cities) { city in
                    HStack {
                        Text(city.fullName)
                        
                        Spacer()
                        if tapped {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                    // background를 넣어야 tap gesture 인식이 list row 전체에 적용됨
                    .background(.white)
                    .onTapGesture {
                        tapped.toggle()
                    }
                    .listRowSeparator(.visible, edges: .all)
                }
                .onChange(of: city) { oldValue, newValue in
                    sm.searchCities(searchText: newValue)
                }
                .listStyle(.plain)
                .padding(.leading, 64)
            }
            Spacer()
            
            Button {
                print("[City] \(city)")
                print("[Date] \(date.string())")
                
                dismiss()
            } label: {
                Text("Add")
                    .frame(width: 100, height: 50)
                    .background(tapped ? .mint : .gray.opacity(0.3))
                    .tint(.white)
                    .clipShape(.rect(cornerRadius: 40))
            }
            .disabled(tapped ? false : true)
        }
        .padding()
        .padding(.vertical)
        .frame(height: 300)
        .onDisappear {
            sm.cities = []
        }
    }
}

#Preview {
    AddSheet(date: .now)
}
