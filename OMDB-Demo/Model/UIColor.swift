//
//  UIColor.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 15/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import UIKit

extension UIColor {

    /// Convenience initializer that generates a UIColor based on an RGB integer value. Takes an
    /// optional `alpha` value.
    ///
    /// - Parameters:
    ///   - rgb: The color's RGB value, e.g. `0xE87722`.
    ///   - alpha: The color's alpha value, from 0 to 1. Defaults to full opacity.
    ///
    convenience init(rgb: Int, alpha: CGFloat = 1) {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// UI `UIColor` instance with color value `#FF8356`.
    static let searchOrange = UIColor(rgb: 0xFF8356)

    /// UI `UIColor` instance with color value `#27243A`
    static let navigationBlue = UIColor(rgb: 0x27243A)

    /// UI `UIColor` instance with color value `#342F56`.
    static let backgroundBlue = UIColor(rgb: 0x342F56)
}
