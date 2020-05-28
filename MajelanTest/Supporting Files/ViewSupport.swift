//
//  ViewSupport.swift
//  MajelanTest
//
//  Created by Florian DERONE on 27/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import UIKit

public extension UIView {
    
    ///
    /// This Inspectable is used to set the corner radius into the main storyboard
    ///
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
}
