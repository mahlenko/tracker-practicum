//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

enum Color: String {
    case black
    case white
    case background
    case grayUniversal
    case lightGrayUniversal
    case redUniversal
    case blueUniversal
}

extension UIColor {
    static func asset(_ color: Color) -> UIColor {
        guard let color = UIColor(named: color.rawValue) else {
            fatalError("Color \"\(color.rawValue)\" not found in assets.")
        }

        return color
    }
}
