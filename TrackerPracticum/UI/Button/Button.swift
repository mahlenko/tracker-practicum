//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

class Button: UIButton {
    private var style: ButtonStyle {
        didSet {
            applyStyle()
        }
    }
    override var isEnabled: Bool {
        didSet {
            applyEnabledStyle()
        }
    }

    override var buttonType: ButtonType {
        .custom
    }

    init(style: ButtonStyle = .normal) {
        self.style = style
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentEdgeInsets = UIEdgeInsets(top: 19, left: 32, bottom: 19, right: 32)
        layer.masksToBounds = true
        layer.cornerRadius = 16
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        applyStyle()
    }

    private func applyStyle() {
        setTitleColor(style.textColor, for: .normal)
        setTitleColor(style.highlightedColor, for: .highlighted)

        switch style {
        case .normal:
            backgroundColor = style.color
        case .dismiss:
            layer.borderColor = style.color.cgColor
            layer.borderWidth = 1
        }
    }

    private func applyEnabledStyle() {
        if isEnabled {
            applyStyle()
        } else {
            setTitleColor(style.disableTextColor, for: .normal)

            switch style {
            case .normal:
                backgroundColor = style.disableColor
            case .dismiss:
                layer.borderColor = style.disableColor.cgColor
                layer.borderWidth = 1
            }
        }
    }
}
