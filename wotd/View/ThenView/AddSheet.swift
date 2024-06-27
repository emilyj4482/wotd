//
//  AddSheet.swift
//  wotd
//
//  Created by EMILY on 14/03/2024.
//

import SwiftUI

struct AddSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = AddSheetViewModel()
    
    @State var date: Date = .now
    @State var city: String = ""
    
    @State private var tapped: Bool = false
    @State private var selectedCity: City?
    
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
                            vm.cities = []
                            tapped = false
                        } label: {
                            Image(systemName: "x.circle.fill")
                        }
                        .tint(.gray.opacity(0.4))
                        .padding(.trailing, 16)
                    }
                }
                
                List(vm.cities) { city in
                    HStack {
                        Text(city.fullName)
                        
                        Spacer()
                        if tapped {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                    // background를 넣어야 tap gesture 인식이 list row 전체에 적용됨
                    .background(Color(.systemBackground))
                    .onTapGesture {
                        tapped.toggle()
                        if tapped {
                            selectedCity = city
                        } else {
                            selectedCity = nil
                        }
                    }
                    .listRowSeparator(.visible, edges: .all)
                }
                .onChange(of: city) { oldValue, newValue in
                    vm.searchCities(searchText: newValue)
                }
                .listStyle(.plain)
                .padding(.leading, 64)
            }
            Spacer()
            
            Button {
                vm.searchWeather(date: date, city: selectedCity)
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
            vm.cities = []
        }
    }
}

#Preview {
    AddSheet(date: .now)
}
