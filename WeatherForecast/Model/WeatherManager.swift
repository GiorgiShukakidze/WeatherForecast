//
//  WeatherManager.swift
//  WeatherForecast
//
//  Created by Giorgi Shukakidze on 8/5/20.
//  Copyright © 2020 Giorgi Shukakidze. All rights reserved.
//

import Foundation

class WeatherManager {
    
    static let shared = WeatherManager()
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?exclude=current,hourly&units=metric&appid=\(Keys.weatherAppId)"
    
    
    func fetchWeahter(for city: City, completion: @escaping (Result<Weather,Error>) -> Void ) {
        
        let url = "\(baseUrl)&lat=\(city.lat)&lon=\(city.lon)"
        
        guard let requestUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: requestUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let safeData = data, error == nil {
                
                if let weatherData = self.parseJSON(for: safeData) {
                    completion(.success(weatherData))
                }
            } else {
                print("error: \(error!.localizedDescription)")
                completion(.failure(error!))
            }
        }.resume()
    }
    
    private func parseJSON(for data: Data) -> Weather? {
        
        do {
            let decodedData = try JSONDecoder().decode(Weather.self, from: data)
            
            return decodedData
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
}
