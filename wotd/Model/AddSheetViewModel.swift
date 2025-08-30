//
//  AddSheetViewModel.swift
//  wotd
//
//  Created by EMILY on 11/06/2024.
//

import Foundation

final class AddSheetViewModel: ObservableObject {
    
    private let searchManager = SearchManager()
    
    @Published var cities: [City] = []
    
    private var request = Request.day
    
    func searchCities(searchText: String) {
        cities = searchManager.request(resultType: .address, searchText: searchText)
    }
    
    func searchWeather(date: Date, city: City?) {
        searchManager.searchWeather(date: date, city: city)
    }
}
