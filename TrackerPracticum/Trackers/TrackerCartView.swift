//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

class TrackerCartView: UIViewController {
    // MARK: - General UI Elements

    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .asset(.whiteUniversal).withAlphaComponent(0.3)
        label.font = .systemFont(ofSize: 16)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .asset(.whiteUniversal)
        label.numberOfLines = 2
        return label
    }()

    private let pinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "pin.fill"), for: .normal)
        button.tintColor = .asset(.whiteUniversal)
        return button
    }()

    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbolLabel, pinButton])
        stackView.distribution = .equalSpacing
        return stackView
    }()

    public lazy var cardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStackView, nameLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 16
        stackView.layer.masksToBounds = true
        return stackView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubview(cardStackView)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }

    func setup(for tracker: Tracker, preferredContentSize size: CGSize? = nil) {
        symbolLabel.text = tracker.symbol
        nameLabel.text = tracker.title
        cardStackView.backgroundColor = tracker.color

        pinButton.isEnabled = tracker.pin
        pinButton.tintColor = tracker.pin // TODO: скорее хак, чем решение
            ? .asset(.whiteUniversal)
            : .asset(.whiteUniversal).withAlphaComponent(0.0)

        if let size = size {
            preferredContentSize = size
        }
    }

    private func setupLayout() {
        [headerStackView, cardStackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            cardStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            cardStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            cardStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            cardStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: cardStackView.leadingAnchor, constant: 12),
            headerStackView.trailingAnchor.constraint(equalTo: cardStackView.trailingAnchor, constant: -12)
        ])
    }
}
