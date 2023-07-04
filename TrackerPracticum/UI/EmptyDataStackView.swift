//
// Created by Сергей Махленко on 02.07.2023.
//

import UIKit

class EmptyDataStackView: UIStackView {
    private let image: UIImage

    private var message: String {
        didSet {
            messageLabel.text = message
        }
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .asset(.black)
        messageLabel.textAlignment = .center
        messageLabel.font = .boldSystemFont(ofSize: 12)
        return messageLabel
    }()

    init(image: UIImage, message: String = "") {
        self.image = image
        self.message = message
        super.init(frame: .zero)

        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addArrangedSubview(imageView)
        addArrangedSubview(messageLabel)

        translatesAutoresizingMaskIntoConstraints = false

        axis = .vertical
        alignment = .center
        spacing = 8
    }

    func setupLayout(safeArea: UILayoutGuide) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
}
