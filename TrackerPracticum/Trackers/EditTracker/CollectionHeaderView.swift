//
// Created by Сергей Махленко on 04.07.2023.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    static var identifier: String {
        String(describing: self)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .asset(.black)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String) {
        titleLabel.text = title
    }

    private func setupView() {
        addSubview(titleLabel)
    }

    private func setupLayout() {
        let safeArea = safeAreaLayoutGuide
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])
    }
}
