//
//  APIManager.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import Foundation

// https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=37.3039&lon=127.0102&dt=1701193357&appid=f27181cb10370ef77a1d09ab93c3fa2f
// https://dapi.kakao.com/v2/local/search/address.json?query=수원

final class APIManager {
    
    let nm = NetworkManager.shared
    
    /* kakao */
    
    // urlComponent
    let kakaoUrlComponent = "https://dapi.kakao.com/v2/local/search/address.json?"
    
    // queries
    func kakaoQuery(location: String) -> [URLQueryItem] {
        let kakaoQuery = URLQueryItem(name: "query", value: location)
        
        return [kakaoQuery]
    }
    
    // headerKey
    let kakaoHeaderKey = "Authorization"
    
    // headerValue
    let kakaoHeaderValue = "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"
    
    func getKakao(location: String) {
        nm.request(urlComponent: kakaoUrlComponent, queries: kakaoQuery(location: location), headerKey: kakaoHeaderKey, headerValue: kakaoHeaderValue, isLocationInfo: true)
    }
    
    /* open weather */
    
    // urlComponent
    let openWeatherComponent = "https://api.openweathermap.org/data/3.0/onecall/timemachine?"
    
    // queries
    func openWeatherQueries(x: String, y: String, dt: String) -> [URLQueryItem] {
        // query : lat, lon, dt, appid
        let latQuery = URLQueryItem(name: "lat", value: y)
        let lonQuery = URLQueryItem(name: "lon", value: x)
        let dtQuery = URLQueryItem(name: "dt", value: dt)
        let appidQuery = URLQueryItem(name: "appid", value: "f27181cb10370ef77a1d09ab93c3fa2f")
        
        return [latQuery, lonQuery, dtQuery, appidQuery]
    }
    
    // header 없음
    
    func getOpenWeather(x: String, y: String, dt: String) {
        nm.request(urlComponent: openWeatherComponent, queries: openWeatherQueries(x: x, y: y, dt: dt), headerKey: nil, headerValue: nil, isLocationInfo: false)
    }
    
}
