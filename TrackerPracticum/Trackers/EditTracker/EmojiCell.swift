//
// Created by Сергей Махленко on 04.07.2023.
//

import UIKit

class EmojiCell: UICollectionViewCell, ReusableCell {
    override var isSelected: Bool {
        didSet {
            toggleSelectAppearance()
        }
    }

    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32)
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

    func setup(emoji: String) {
        emojiLabel.text = emoji
    }

    private func setupView() {
        contentView.addSubview(emojiLabel)
        layer.cornerRadius = 16
    }

    private func setupLayout() {
        let safeArea = contentView.safeAreaLayoutGuide

        emojiLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emojiLabel.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            emojiLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
        ])
    }

    private func toggleSelectAppearance() {
        if isSelected {
            backgroundColor = .asset(.lightGrayUniversal)
        } else {
            backgroundColor = .none
        }
    }
}
