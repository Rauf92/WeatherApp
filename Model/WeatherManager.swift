//
//  ParsingModel.swift
//  WeatherApp
//
//  Created by Rauf Aliyev on 18.01.22.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}


struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=55191998788e1ebc9a50f04a6f8648e4&units=metric&q="
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(_ cityName: String){
        let urlString = weatherURL + cityName
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData : Data)-> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temperature = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(conditionId: id, temperature: temperature)
            return weather
        } catch{
            print(error)
            return nil
        }
    }
   
}
    
