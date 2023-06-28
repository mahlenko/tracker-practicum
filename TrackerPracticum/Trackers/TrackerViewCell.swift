//
// Created by Сергей Махленко on 08.06.2023.
//

import UIKit

final class TrackerViewCell: UICollectionViewCell, ReusableCell {
    // MARK: - Cart UI Elements

    private var tracker: Tracker?

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
        button.imageView?.contentMode = .scaleAspectFill
        // TODO: imageEdgeInsets deprecated IOS 15, а чем заменить?
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return button
    }()

    private lazy var headerStackView: UIStackView = {
        let pinButtonView = UIView()
        pinButtonView.addSubview(pinButton)

        let stackView = UIStackView(arrangedSubviews: [symbolLabel, pinButtonView])
        stackView.distribution = .equalSpacing
        return stackView
    }()

    public lazy var cardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStackView, nameLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 16
        stackView.layer.masksToBounds = true
        return stackView
    }()

    // MARK: - Actions UI elements

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .asset(.black)
        return label
    }()

    private let quantityButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .asset(.blueUniversal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .asset(.white)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Helpers elements

    private lazy var quantityActionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quantityLabel, quantityButton])
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 12, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    lazy private var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cardStackView,
            quantityActionStackView
        ])

        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Setup methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func setup(for tracker: Tracker) {
        self.tracker = tracker

        symbolLabel.text = tracker.symbol
        nameLabel.text = tracker.title
        pinButton.isHidden = !tracker.pin

        cardStackView.backgroundColor = tracker.color
        quantityButton.backgroundColor = tracker.color
    }

    // MARK: - Private methods

    private func setupView() {
        quantityLabel.text = "1 день"

        contentView.addSubview(contentStackView)
        // TODO не разобрался как сделать, чтобы не обрезалась карточка при длинном тапе, до появления меню
        cardStackView.addInteraction(UIContextMenuInteraction(delegate: self))
    }

    private func setupLayout() {
        let safeArea = contentView.safeAreaLayoutGuide

        [quantityButton, contentStackView, symbolLabel, pinButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            quantityButton.widthAnchor.constraint(equalToConstant: 34),
            quantityButton.heightAnchor.constraint(equalTo: quantityButton.widthAnchor, multiplier: 1)
        ])

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            symbolLabel.widthAnchor.constraint(equalToConstant: 24),
            symbolLabel.heightAnchor.constraint(equalToConstant: 24)
        ])

        guard let pinView = pinButton.superview else { return }
        NSLayoutConstraint.activate([
            pinButton.trailingAnchor.constraint(equalTo: pinView.trailingAnchor, constant: 8),
            pinButton.centerYAnchor.constraint(equalTo: pinView.centerYAnchor),
            pinButton.widthAnchor.constraint(equalToConstant: 24),
            pinButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

extension TrackerViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint
    ) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            guard
                let self,
                let tracker = self.tracker
            else { return nil }

            return tracker.contextMenu()
        }
    }
}
