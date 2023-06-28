//
// Created by Сергей Махленко on 08.06.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension TrackerViewCell: ReusableView {
    static var identifier: String {
        String(describing: self)
    }
}

class TrackerViewCell: UICollectionViewCell {
    // MARK: - General UI Elements

    let cartView = TrackerCartView()

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
            cartView.view,
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
        cartView.setup(for: tracker)
        quantityButton.backgroundColor = tracker.color
    }

    // MARK: - Private methods

    private func setupView() {
        quantityLabel.text = "1 день"
        contentView.addSubview(contentStackView)
        backgroundColor = .none
    }

    private func setupLayout() {
        let safeArea = contentView.safeAreaLayoutGuide

        [quantityButton, contentStackView].forEach { view in
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
    }
}
