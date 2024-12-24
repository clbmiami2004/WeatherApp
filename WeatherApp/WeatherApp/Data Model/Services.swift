//
//  Services.swift
//  WeatherApp
//
//  Created by Chris on 12/14/24.
//

        //My weather API from openweathermap.org
        //https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiID)
        //http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(apiID)&units=imperial


import Foundation

class Services {
    
    let apiID = "821ebd602e76b616bd20438c54140300"
    
    // Function to get the weather:
    func getWeatherData(city: String, completion: @escaping (MainWeatherParams?, WindWeatherParams?, CloudWeatherParams?) -> ()) {
        
        // My weather API from openweathermap.org
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(apiID)&units=imperial"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error making request: \(error.localizedDescription)")
                completion(nil, nil, nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, nil, nil)
                return
            }
            
            do {
                let mainResponse = try JSONDecoder().decode(Mainweather.self, from: data)
                let windResponse = try JSONDecoder().decode(Windweather.self, from: data)
                let cloudyResponse = try JSONDecoder().decode(Cloudweather.self, from: data)
                
                completion(mainResponse.main, windResponse.wind, cloudyResponse.clouds)
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                completion(nil, nil, nil)
            }
        }.resume()
    }
}

        
        
