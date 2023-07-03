//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

enum Color: String {
    case black
    case white
    case whiteUniversal
    case background
    case grayUniversal
    case lightGrayUniversal
    case redUniversal
    case blueUniversal
}

extension UIColor {
    static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        UIColor.rgba(red, green, blue, 1.0)
    }

    static func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) -> UIColor {
        UIColor.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: alpha
        )
    }

    static func asset(_ color: Color) -> UIColor {
        guard let color = UIColor(named: color.rawValue) else {
            fatalError("Color \"\(color.rawValue)\" not found in assets.")
        }

        return color
    }
}
