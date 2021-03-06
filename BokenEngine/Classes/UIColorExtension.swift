//
//  UIColorExtention.swift
//  Boken Engine
//
//  Created by Yeray on 12/11/2020.
//  Copyright © 2020 Hyve. All rights reserved.
//

import UIKit

extension UIColor {
    static func == (left: UIColor, right: UIColor) -> Bool {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        left.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0
        right.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        return red1 == red2 && green1 == green2 && blue1 == blue2 && alpha1 == alpha2
    }
}
func == (left: UIColor?, right: UIColor?) -> Bool {
    let left = left ?? .clear
    let right = right ?? .clear
    return left == right
}
