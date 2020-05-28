//
//  ViewControllerSupport.swift
//  MajelanTest
//
//  Created by Florian DERONE on 27/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    ///
    /// This function is used to get the image by the category
    ///
    public func getCategoryImage(_ category: String) -> UIImage {
        
        switch category.lowercased() {
        case "beef": return UIImage.init(named: "beef")!
            case "chicken": return UIImage.init(named: "chicken")!
            case "dessert": return UIImage.init(named: "dessert")!
            case "lamb": return UIImage.init(named: "lamb")!
            case "miscellaneous": return UIImage.init(named: "miscellaneous")!
            case "pasta": return UIImage.init(named: "pasta")!
            case "pork": return UIImage.init(named: "pork")!
            case "seafood": return UIImage.init(named: "seafood")!
            case "side": return UIImage.init(named: "side")!
            case "vegetarian": return UIImage.init(named: "vegetarian")!
        default: break
        }
        
        return UIImage.init()
        
    }
    
    ///
    /// This function is used to get the color by the category
    ///
    public func getCategoryColor(_ category: String) -> UIColor {
        
        switch category.lowercased() {
        case "beef": return UIColor.init(named: "beefColor")!
            case "chicken": return UIColor.init(named: "chickenColor")!
            case "dessert": return UIColor.init(named: "dessertColor")!
            case "lamb": return UIColor.init(named: "lambColor")!
            case "miscellaneous": return UIColor.init(named: "miscellaneousColor")!
            case "pasta": return UIColor.init(named: "pastaColor")!
            case "pork": return UIColor.init(named: "porkColor")!
            case "seafood": return UIColor.init(named: "seafoodColor")!
            case "side": return UIColor.init(named: "sideColor")!
            case "vegetarian": return UIColor.init(named: "vegetarianColor")!
        default: break
        }
        
        return .white
        
    }
    
    ///
    /// This function is used to get the flag image by the area
    ///
    public func getAreaFlag(area: String) -> UIImage {
        
        switch area.lowercased() {
            case "american" : return UIImage.init(named: "american")!
            case "irish" : return UIImage.init(named: "ireland")!
            case "greek" : return UIImage.init(named: "greece")!
            case "french" : return UIImage.init(named: "france")!
            case "thai" : return UIImage.init(named: "thailand")!
            case "british" : return UIImage.init(named: "british")!
            case "canadian" : return UIImage.init(named: "canada")!
            case "dutch" : return UIImage.init(named: "netherland")!
            case "italian" : return UIImage.init(named: "italy")!
            case "chinese" : return UIImage.init(named: "chinese")!
            case "turkish" : return UIImage.init(named: "turkey")!
            case "indian" : return UIImage.init(named: "india")!
            case "tunisian" : return UIImage.init(named: "tunisia")!
            case "egyptian" : return UIImage.init(named: "egyptian")!
            case "japanese" : return UIImage.init(named: "japan")!
        default: break
        }
        
        return UIImage.init()
        
    }
    
}
