//
//  AllMealsViewModel.swift
//  MajelanTest
//
//  Created by Florian DERONE on 26/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import Foundation
import UIKit

class MealsViewModel
{
    private var mealsDataFetcher: MealsDataFetcher?
    
    // MARK: - Properties
    private var allMeals : AllMeals?
    
    public var meals : [Meals] = []
    
    var error: Error? { didSet { self.showAlertClosure?() } }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var didFinishFetchAllMeals: (() -> ())?
    
    // MARK: - Constructor
    init(mealsDataFetcher: MealsDataFetcher) {
        self.mealsDataFetcher = mealsDataFetcher
    }
    
}

// MARK: - Network call
extension MealsViewModel {
    
    ///
    /// This function fills all `meals`.
    ///
    func fetchAllMeals() {

        let allMealsOperation = OperationQueue()
        
        let mealsOperation = BlockOperation {
            
            let group = DispatchGroup()
                
            self.fetchMeals(group)
            
            group.notify(queue: .main, execute: {
                self.fillAllMeals()
                self.didFinishFetchAllMeals?()
            })
            
        }
        
        allMealsOperation.addOperation(mealsOperation)
        
    }
    
    /// This function fills `meals`.
    ///
    /// - Parameter group : Groups allow you to aggregate a set of tasks and synchronize behaviors on the group.
    ///
    private func fetchMeals(_ group : DispatchGroup) {

        group.enter()
        
        self.mealsDataFetcher?.requestFetchAllMeals(completion: { meals, error in
            
            if let error = error {
                self.error = error
                group.leave()
                return
            }
            
            self.error = nil
            if meals != nil { self.allMeals = meals! }
            group.leave()
            
        })
        
        group.wait()
        
    }
    
}

// MARK: - Build Object
extension MealsViewModel {
    
    ///
    /// This function is used to build the meals list
    ///
    private func fillAllMeals() {
        
        guard self.allMeals != nil else { return }
        guard let allMeals = self.allMeals!.meals else { return }
        
        self.meals = []
        
        for mealInformations in allMeals {
            
            var id : Int?
            var meal, drinkAlternate, category, area: String?
            var instructions, tags, source, dateModified: String?
            var mealThumb, youtube : URL?
            var ingredients = Array<String?>(repeating: "", count: 20)
            var measures = Array<String?>(repeating: "", count: 20)
            
            for mealInformation in mealInformations {
                
                let information = mealInformation.value
                if mealInformation.key == "idMeal" { id = Int(information ?? "") }
                if mealInformation.key == "strMeal" { meal = information }
                if mealInformation.key == "strDrinkAlternate" { drinkAlternate = information }
                if mealInformation.key == "strCategory" { category = information }
                if mealInformation.key == "strArea" { area = information }
                if mealInformation.key == "strInstructions" { instructions = information }
                if mealInformation.key == "strMealThumb" { mealThumb = URL(string: information ?? "") }
                if mealInformation.key == "strTags" { tags = information }
                if mealInformation.key == "strYoutube" { youtube = URL(string: information ?? "") }
                
                if mealInformation.key.contains("strIngredient") {
                    ingredients[(Int(mealInformation.key.replacingOccurrences(of: "strIngredient", with: ""))! - 1)] = information
                }
                
                if mealInformation.key.contains("strMeasure") {
                    measures[(Int(mealInformation.key.replacingOccurrences(of: "strMeasure", with: ""))! - 1)] = information
                }
                
                if mealInformation.key == "strSource" { source = information }
                if mealInformation.key == "dateModified" { dateModified = information }
                
            }
            
            // Remove empty ingredients & measures
            ingredients = ingredients.filter({ $0 != "" })
            ingredients = ingredients.filter({ $0 != " " })
            ingredients = ingredients.filter({ $0 != nil })
            measures = measures.filter({ $0 != "" })
            measures = measures.filter({ $0 != " " })
            measures = measures.filter({ $0 != nil })
            
            self.meals.append(Meals(id: id,
                                    meal: meal,
                                    drinkAlternate: drinkAlternate,
                                    category: category,
                                    area: area,
                                    instructions: instructions,
                                    mealThumb: mealThumb,
                                    tags: tags,
                                    youtube: youtube,
                                    ingredients: ingredients,
                                    measures: measures,
                                    source: source,
                                    dateModified: dateModified))
            
        }
        
        // Alphabetical sort
        self.meals = self.meals.sorted { $0.meal! < $1.meal! }
        
    }
    
}
