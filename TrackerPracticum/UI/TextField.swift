//
// Created by Сергей Махленко on 03.07.2023.
//

import UIKit

class TextField: UITextField {
    var textPadding = UIEdgeInsets(top: 19, left: 16, bottom: 19, right: 41)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .asset(.background)
        clearButtonMode = .always
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
