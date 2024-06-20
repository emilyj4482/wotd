//
//  ThenWeather.swift
//  wotd
//
//  Created by EMILY on 25/03/2024.
//

import SwiftUI

struct ThenWeather: Hashable, Codable {
    var date: Date
    var city: String
    
    var min: Int
    var max: Int
    
    var morning: Int
    var afternoon: Int
    var evening: Int
    var night: Int
    
    var colors: [Color] {
        let avg = (min + max) / 2
        
        if avg <= 0 {
            return [
                Color(uiColor: #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1))
            ]
        } else if avg > 0 && avg <= 5 {
            return [
                Color(uiColor: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1))
            ]
        } else if avg > 5 && avg <= 10 {
            return [
                Color(uiColor: #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1))
            ]
        } else if avg > 10 && avg <= 15 {
            return [
                Color(uiColor: #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1))
            ]
        } else if avg > 15 && avg <= 20 {
            return [
                Color(uiColor: #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
            ]
        } else if avg > 20 && avg <= 25 {
            return [
                Color(uiColor: #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
            ]
        } else if avg > 25 && avg <= 30 {
            return [
                Color(uiColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
            ]
        } else {
            return [
                Color(uiColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            ]
        }
    }
}
