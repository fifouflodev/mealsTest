//
//  AllMealsDataFetcher.swift
//  MajelanTest
//
//  Created by Florian DERONE on 26/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import Foundation
import UIKit

struct MealsDataFetcher {
    
    // MARK: - Singleton
    static let shared = MealsDataFetcher()
    static let baseUrl = (AppDelegate.readfromInfoPlist(key: "RootUrl") ?? "https://www.themealdb.com") + "/api/json/v1/1/"
    
}

// MARK: - AllMeals
extension MealsDataFetcher {
    
    /// This function is used to fetch all meals.
    ///  
    /// Usage:
    ///
    ///     GET 'https://www.themealdb.com/api/json/v1/1/search.php?s'
    ///
    /// - Parameter completion : The handler with the meals list
    ///
    /// - Returns: A completion handler with the meals list
    func requestFetchAllMeals(completion: @escaping (AllMeals?, Error?) -> Void = { _,_ in }) {
        
        guard let url = URL(string: MealsDataFetcher.baseUrl + "search.php?s") else {
            let description = String(format: "Wrong Url")
            completion(nil, AppError.custom(errorDescription: description))
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    completion(nil, error)
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                let description = String(format: "Wrong Status Code", "\(response.statusCode)")
                completion(nil, AppError.custom(errorDescription: description))
                return
            }
            
            completion(try? JSONDecoder().decode(AllMeals.self, from: data), nil)
            
        }.resume()
        
    }
    
}
