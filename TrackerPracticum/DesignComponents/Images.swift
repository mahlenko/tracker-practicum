//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

enum Image: String {
    case emptyList
}

extension UIImage {
    static func asset(_ image: Image) -> UIImage {
        guard let image = UIImage(named: image.rawValue) else {
            fatalError("Image \"\(image.rawValue)\" not found in assets.")
        }

        return image
    }
}
