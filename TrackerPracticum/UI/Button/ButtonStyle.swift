//
// Created by Сергей Махленко on 04.07.2023.
//

import UIKit

enum ButtonStyle {
    case normal
    case dismiss

    var color: UIColor {
        switch self {
        case .normal:
            return .asset(.black)
        case .dismiss:
            return .asset(.redUniversal)
        }
    }

    var textColor: UIColor {
        switch self {
        case .normal:
            return .asset(.white)
        case .dismiss:
            return .asset(.redUniversal)
        }
    }

    var highlightedColor: UIColor {
        switch self {
        case .normal:
            return .asset(.grayUniversal)
        case .dismiss:
            return .asset(.redUniversal)
        }
    }

    var disableColor: UIColor {
        switch self {
        case .normal:
            return .asset(.grayUniversal)
        case .dismiss:
            return .asset(.redUniversal)
        }
    }

    var disableTextColor: UIColor {
        switch self {
        case .normal:
            return .asset(.whiteUniversal)
        case .dismiss:
            return .asset(.redUniversal)
        }
    }
}
