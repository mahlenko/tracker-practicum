//
// Created by Сергей Махленко on 04.07.2023.
//

import UIKit

class ColorCell: UICollectionViewCell, ReusableCell {
    private var color: UIColor
    private let rounded: CGFloat = 8
    private let borderSize: CGFloat = 3
    private let spacingWrapper: CGFloat = 6
    override var isSelected: Bool {
        didSet {
            toggleSelectAppearance()
        }
    }
    private lazy var itemWrapperView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.borderWidth = borderSize
        stackView.layer.borderColor = UIColor.asset(.white).withAlphaComponent(0).cgColor
        stackView.layer.cornerRadius = rounded + spacingWrapper
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: spacingWrapper,
            left: spacingWrapper,
            bottom: spacingWrapper,
            right: spacingWrapper)

        return stackView
    }()

    private lazy var itemView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = rounded
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        color = UIColor.asset(.white)
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(color: UIColor) {
        self.color = color
        itemView.backgroundColor = color
    }

    private func setupView() {
        itemWrapperView.addArrangedSubview(itemView)
        contentView.addSubview(itemWrapperView)
    }

    private func setupLayout() {
        let safeArea = contentView.safeAreaLayoutGuide

        [itemWrapperView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            itemWrapperView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            itemWrapperView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            itemWrapperView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            itemWrapperView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])
    }

    private func toggleSelectAppearance() {
        if isSelected {
            itemWrapperView.layer.borderColor = color
                .resolvedColor(with: traitCollection)
                .withAlphaComponent(0.3).cgColor
        } else {
            itemWrapperView.layer.borderColor = UIColor.asset(.white)
                .resolvedColor(with: traitCollection)
                .withAlphaComponent(0).cgColor
        }
    }
}
