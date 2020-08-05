//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Giorgi Shukakidze on 8/5/20.
//  Copyright © 2020 Giorgi Shukakidze. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let daily: [WeatherData]
}

struct WeatherData: Codable {
    let dt: Int
    let temp: TemperatureData
}

struct TemperatureData: Codable {
    let day: Double
}
