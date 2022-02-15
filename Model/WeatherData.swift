//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Rauf Aliyev on 18.01.22.
//

import Foundation

struct WeatherData: Codable {
    var main: main
    var weather: [Weather]
}

struct main: Codable {
    var temp: Double
}


struct Weather: Codable {
    var id: Int
}
