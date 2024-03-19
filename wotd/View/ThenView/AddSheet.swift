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
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        .tint(.gray.opacity(0.4))
                    }
                }
                
                List(sm.cities) { city in
                    Text(city.fullName)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.gray).opacity(0.1))
                }
                .onChange(of: city) { oldValue, newValue in
                    sm.searchCities(searchText: newValue)
                }
                .listStyle(.plain)
                .padding(.leading, 64)
            }
            Spacer()
            
            Button("Add") {
                print("[City] \(city)")
                print("[Date] \(date)")
                
                dismiss()
            }
            .frame(width: 100, height: 50)
            .background(.mint)
            .tint(.white)
            .clipShape(.rect(cornerRadius: 40))
        }
        .padding()
        .padding(.vertical)
        .frame(height: 300)
    }
}

#Preview {
    AddSheet(date: .now)
}
