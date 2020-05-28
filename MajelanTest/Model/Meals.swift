//
//  Meals.swift
//  MajelanTest
//
//  Created by Florian DERONE on 26/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import Foundation

// MARK: - Meals
struct Meals {
    var id: Int?
    var meal, drinkAlternate, category: String?
    var area, instructions: String?
    var mealThumb: URL?
    var tags: String?
    var youtube: URL?
    var ingredients : [String?]?
    var measures : [String?]?
    var source: String?
    var dateModified: String?
}
