//
//  Weather.swift
//  Working With JSON (Dark Sky)
//
//  Created by Charles Martin Reed on 1/18/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit

struct Weather {
    let summary: String //weather desc
    let icon: String //used for images
    let highTemperature: Double
    let lowTemperature: Double
    
    //since JSON serialization throws, we'll use an enum to encapuslate our potential fail states
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    //we may or may not get dicts containing necessary info from our JSON serializaton - we're throwing to our SerializationError enum cases to handle any potentially missing info.
    init(json:[String: Any]) throws {
        guard let summary = json["summary"] as? String else { throw SerializationError.missing("Summary is not available for the retrieved data")}
        guard let icon = json["icon"] as? String else { throw SerializationError.missing("Weather icon is not available for the retrieved data")}
        guard let highTemperature = json["temperatureHigh"] as? Double else { throw SerializationError.missing("High temperature info is not available for the retreived data")}
        guard let lowTemperature = json["temperatureLow"] as? Double else { throw SerializationError.missing("Low temperature info is not available for the retrieved data")}
        
        self.summary = summary
        self.icon = icon
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
    }
    
    //define basePath for API calls - uses personal API key
    static let basePath = "https://api.darksky.net/forecast/27809acca85d52025f0ed66c9603ed47/"
    
    static func forecast(withLocation location: String, completion: @escaping ([Weather]?) -> ()) {
        
        //define the url
        let url = basePath + location //pair of coordinates
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            //handle the data we get from the request
            var forecastArray = [Weather]()
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        //access the dictionary data received from DarkSky
                        if let dailyForecasts = json["daily"] as? [String: Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String: Any]] {
                                //iterate through data points and create weather object
                                for dataPoint in dailyData {
                                    if let weatherObj = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObj)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                //call your completion handler here to trigger the process
                completion(forecastArray)
            }
            
        }
        task.resume()
    }
}
