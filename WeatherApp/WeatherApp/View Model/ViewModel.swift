//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Chris on 12/14/24.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    var weatherService: Services!
    
    init() {
        self.weatherService = Services()
    }
    
    var cityName: String = "" {
        didSet {
            if cityName.isEmpty {
                resetWeatherData()
            }
        }
    }
    
    @Published var mainWeather = MainWeatherParams()
    @Published var windWeather = WindWeatherParams()
    @Published var cloudWeather = CloudWeatherParams()
    
    //Computed Properties:
    var temperature: String {
        if let temp = mainWeather.temp {
            let modifiedString = String(format: "%.0f", temp)
            return modifiedString + "°"
        } else {
            return ""
        }
    }
    
    var humid: String {
        if let humidity = mainWeather.humidity {
            let modifiedString = String(format: "%.0f", humidity)
            return modifiedString + "%"
        } else {
            return ""
        }
    }
    
    var press: String {
        if let pressure = mainWeather.pressure {
            let modifiedString = String(format: "%.0f", pressure)
            return modifiedString
        } else {
            return ""
        }
    }
    
    var windSpeed: String {
        if let speed = windWeather.speed {
            return String(speed)
        } else {
            return ""
        }
    }
    
    var windDirection: String {
        if let direction = self.windWeather.deg {
            return windDirectionFromDegrees(degrees: direction)
        } else {
            return ""
        }
    }
    
    var cloudPercent: String {
        if let cloudiness = self.cloudWeather.all {
            let modifiedString = String(format: "%.0f", cloudiness)
            return modifiedString + "%"
        } else {
            return ""
        }
    }
    
    
    
    //Function to convert wind to degrees into direction:
    func windDirectionFromDegrees(degrees: Double) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((degrees + 11.25) / 22.5)
        return directions[i % 16]
    }
    
    //Check the user entered string
    func cityLookup() {
        //addingPercentEncoding allows to lookup for the city by ignoring spaces in the city names, such as: Los Angeles. This won't run on the URL unless we do this to precent this issue.
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            updateWeatherViews(by: city)
        }
    }
    
    func updateWeatherViews(by city: String) {
        self.weatherService.getWeatherData(city: city) { (weather, wind, clouds) in
            if let weather = weather {
                if let wind = wind {
                    if let cloud = clouds {
                        DispatchQueue.main.async {
                            self.mainWeather = weather
                            self.windWeather = wind
                            self.cloudWeather = cloud
                        }
                    }
                }
            }
        }
    }
    
    //Reset Weather Data
    func resetWeatherData() {
        self.mainWeather = MainWeatherParams()
        self.windWeather = WindWeatherParams()
        self.cloudWeather = CloudWeatherParams()
    }
}
