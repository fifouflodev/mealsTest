//
//  SectionHeaderView.swift
//  MajelanTest
//
//  Created by Florian DERONE on 27/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier: String = String(describing: self)

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    @IBOutlet override var textLabel: UILabel? {
        get { return _textLabel }
        set { _textLabel = newValue }
    }
    
    private var _textLabel: UILabel?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var view: UIView!
    
}
