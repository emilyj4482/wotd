//
//  ThenWeather.swift
//  wotd
//
//  Created by EMILY on 25/03/2024.
//

import CoreLocation

class ThenWeather {
    var date: String
    var city: String
    
    var x: String
    var y: String
    
    var min: Int
    var max: Int
    
    var morning: Int
    var afternoon: Int
    var evening: Int
    var night: Int
    
    var request = Request(
            urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
            params: [
                "lat": "",
                "lon": "",
                "date": "",
                "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
                "units": "metric"
            ]
        )
    
    init(date: String, city: String, x: String, y: String, min: Int, max: Int, morning: Int, afternoon: Int, evening: Int, night: Int) {
        self.date = date
        self.city = city
        self.x = x
        self.y = y
        self.min = min
        self.max = max
        self.morning = morning
        self.afternoon = afternoon
        self.evening = evening
        self.night = night
    }
    
    func setDate(date: Date) {
        let date = date.string()
        self.date = date
        request.params.updateValue(date, forKey: "date")
    }

    func setCoordinate(coordinate: CLLocationCoordinate2D) {
        let x = "\(coordinate.longitude)"
        let y = "\(coordinate.latitude)"
        
        self.x = x
        self.y = y

        request.params.updateValue(x, forKey: "lon")
        request.params.updateValue(y, forKey: "lat")
    }
    
    func requestData() {
        request.dataTask(WeatherInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let temp = information?.temperature {
                    self?.min = temp.min.int()
                    self?.max = temp.max.int()
                    self?.morning = temp.morning.int()
                    self?.afternoon = temp.afternoon.int()
                    self?.evening = temp.evening.int()
                    self?.night = temp.night.int()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
