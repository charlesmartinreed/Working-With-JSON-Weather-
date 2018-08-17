//
//  Weather.swift
//  JSON
//
//  Created by Charles Martin Reed on 8/17/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation

//our data model
struct Weather {
    let summary: String
    let icon: String
    let temperature: Double
    
    //conforms to the Error protocol
    //returns error if the JSON initializtion fails
    enum SeralizationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    //because JSON returns as a dictionary
    init(json:[String:Any]) throws {
        
        //using guard statements here because our init throws
        guard let summary = json["summary"] as? String else {
            throw SeralizationError.missing("Summary is missing")
        }
        
        guard let icon = json["icon"] as? String else {
            throw SeralizationError.missing("Icon is missing")
        }
        
        guard let temperature = json["temperatureMax"] as? Double else {
            throw SeralizationError.missing("Temperature is missing")
        }
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        
    }
    
    //now includes my personal API key
    static let basePath = "https://api.darksky.net/forecast/27809acca85d52025f0ed66c9603ed47/"
    
    //defined statically so we don't need to create a specific instance to use the func
    //@escaping means the closures scope continues to exist in memory AFTER execution, thus allowing the cosure to be executed asynchronously.
    
    static func forecast(withLocation location:String, completion: @escaping([Weather]) -> ()) {
        
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray: [Weather] = []
            
            if let data = data {
                do {
                    //JSON serialization converts to Foundation objects
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        //drill down into the JSON data
                        if let dailyForecasts = json["daily"] as? [String: Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String: Any]] {
                                //remember that json returns dict
                                //we're looping over a collection of dicts
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                //call your completion handler
                completion(forecastArray)
            }
            
        }
        
        task.resume()
        
    }

    
}
