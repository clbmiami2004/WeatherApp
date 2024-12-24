//
//  MainWeatherParams.swift
//  WeatherApp
//
//  Created by Chris on 12/14/24.
//Web: https://home.openweathermap.org/api_keys
//API Key: c73ca493e8be3f6f73270750424c6ffb

import Foundation


//Main Weather
struct Mainweather: Decodable {
    var main: MainWeatherParams
}
struct MainWeatherParams: Decodable {
    var temp: Double?
    var humidity: Double?
    var pressure: Double?
}


//Wind weather
struct Windweather: Decodable {
    var wind: WindWeatherParams
}
struct WindWeatherParams: Decodable {
    var speed: Double?
    var deg: Double? //Wind direction in degrees
}


//Cloud weather
struct Cloudweather: Decodable {
    var clouds: CloudWeatherParams
}
struct CloudWeatherParams: Decodable {
    var all: Double?
}
