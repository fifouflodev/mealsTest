//
//  AllMeals.swift
//  MajelanTest
//
//  Created by Florian DERONE on 26/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import Foundation

// MARK: - AllMeals
struct AllMeals: Codable {
    var meals: [[String: String?]]?
}

// MARK: AllMeals convenience initializers and mutators

extension AllMeals {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AllMeals.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        meals: [[String: String?]]?? = nil
    ) -> AllMeals {
        return AllMeals(
            meals: meals ?? self.meals
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}
