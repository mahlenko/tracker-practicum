//
// Created by Сергей Махленко on 02.07.2023.
//

import UIKit

final class StatisticViewCell: UICollectionViewCell, ReusableCell {
    override var contentView: UIView {
        let contentView = super.contentView

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1

        return contentView
    }

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .asset(.black)
        label.font = .systemFont(ofSize: 34, weight: .bold)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .asset(.black)
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(contentStackView)
    }

    private func setupLayout() {
        let safeArea = contentView.safeAreaLayoutGuide

        [contentStackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            contentStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
        ])
    }

    func setup(for item: StatisticItem) {
        // TODO
        //  Можно сразу в StatisticItem использовать Int вместо Double
        //  и не использовать format, но тут скорее "заход" на будущее.
        valueLabel.text = String(format: "%.0f", item.value)
        titleLabel.text = item.title

        // TODO тут этому не место, но у меня размеры не определяются в другом месте
        contentView.layer.borderGradient(colors: [
            UIColor.rgb(257, 76, 73).cgColor,
            UIColor.rgb(70, 230, 157).cgColor,
            UIColor.rgb(0, 123, 255).cgColor
        ])
    }
}
