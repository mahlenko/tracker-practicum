//
// Created by Сергей Махленко on 28.06.2023.
//

import Foundation

protocol ReusableCell: AnyObject {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        String(describing: self)
    }
}
