//
//  SearchManager.swift
//  wotd
//
//  Created by EMILY on 18/03/2024.
//

import Foundation
import MapKit

final class SearchManager: ObservableObject {
    
    static let shared = SearchManager()
    
    @Published var cities: [City] = []
    
    func searchCities(searchText: String) {
        request(resultType: .address, searchText: searchText)
    }
    
    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest, searchText: String) {
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else {
                print("[ERROR] \(error?.localizedDescription ?? "Unknown error occured")")
                return
            }
            self?.cities = response.mapItems.map(City.init)
        }
    }
}
