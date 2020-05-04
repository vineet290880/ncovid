//
//  RestServices.swift
//  ncovid19
//
//  Created by Vineet Pathak on 2020-04-15.
//  Copyright © 2020 Vineet Pathak. All rights reserved.
//

import Foundation
class RestServices {
    static let shared = RestServices()
    fileprivate let baseURL = "https://corona-api.com"
    
    func fetchCovidData(country:String, completion: @escaping (Result<CovidModel, Error>) -> Void) {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "corona-api.com"
        componentURL.path = "/countries/\(country)"
        
        guard let validURL = componentURL.url else {
            print("URL Creation failed.")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            guard let validData = data, error == nil else {
                print("Error getting valid data")
                completion(.failure(error!))
                return
            }
            do {
                let covidData = try JSONDecoder().decode(CovidModel.self, from: validData)
                completion(.success(covidData))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
}
