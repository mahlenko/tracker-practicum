//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .asset(.black)
        contentEdgeInsets = UIEdgeInsets(top: 19, left: 32, bottom: 19, right: 32)
        layer.masksToBounds = true
        layer.cornerRadius = 16
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        setTitleColor(.asset(.white), for: .normal)
        setTitleColor(.asset(.grayUniversal), for: .highlighted)
    }
}
