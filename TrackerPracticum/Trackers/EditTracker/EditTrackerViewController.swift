//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

final class EditTrackerViewController: UIViewController {
    // MARK: - Base variables

    private let isRegular: Bool
    private let tracker: Tracker?
    private let viewModel = EditViewModel()

    // MARK: - UI Elements

    private lazy var completedCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .asset(.black)
        label.textAlignment = .center
        label.text = "5 дней"
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let field = TextField()
        field.placeholder = "Введите название трекера"
        return field
    }()

    private lazy var contentStackView: UIStackView = {
        var subviews: [UIView] = [nameTextField, trackerAppearanceCollectionView]
        if tracker != nil { subviews.insert(completedCountLabel, at: 0) }

        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.backgroundColor = .asset(.white)
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var trackerAppearanceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collection.allowsMultipleSelection = true
        collection.delegate = self
        collection.dataSource = self
        viewModel.sections.forEach { item in
            collection.register(item.cell, forCellWithReuseIdentifier: item.cell.identifier)
        }
        collection.register(
            CollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionHeaderView.identifier)

        return collection
    }()

    private let dismissButton: Button = {
        let button = Button(style: .dismiss)
        button.setTitle("Отменить", for: .normal)
        return button
    }()

    private lazy var submitButton: Button = {
        let button = Button()
        button.setTitle(
            tracker == nil ? "Создать" : "Сохранить",
            for: .normal)

        button.isEnabled = false
        return button
    }()

    private lazy var submitStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dismissButton, submitButton])
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .asset(.white)
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: - Show view

    init(tracker: Tracker? = nil, isRegular: Bool = false) {
        self.tracker = tracker
        self.isRegular = isRegular
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    private func setupView() {
        view.backgroundColor = .asset(.white)

        title = tracker == nil
            ? "Новая привычка"
            : "Редактирование привычки"

        view.addSubview(contentStackView)
        view.addSubview(submitStackView)

        dismissButton.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        [contentStackView, submitStackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            submitStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            submitStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            submitStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])
    }
}

extension EditTrackerViewController {
    @objc private func tapDismissButton() {
        dismiss(animated: true)
    }
}

extension EditTrackerViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        5
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 52, height: 52)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 2, bottom: 24, right: 2)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // We allow you to select only 1 cell in the section
        collectionView.indexPathsForSelectedItems?.forEach { path in
            guard
                path.section == indexPath.section,
                path.row != indexPath.row
            else { return }

            collectionView.deselectItem(at: path, animated: false)
        }
    }
}

extension EditTrackerViewController: UICollectionViewDelegate {
    // MARK: - Collection header

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: 23.0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CollectionHeaderView.identifier,
                for: indexPath) as? CollectionHeaderView
            else { fatalError("Header collection not found.") }

            let section = viewModel.sections[indexPath.section]
            headerView.setup(title: section.name)

            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
}

extension EditTrackerViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.sections[section].items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: section.cell.identifier,
            for: indexPath)

        if let cell = cell as? EmojiCell, let item = item as? String {
            cell.setup(emoji: item)
        }

        if let cell = cell as? ColorCell, let item = item as? UIColor {
            cell.setup(color: item)
        }

        return cell
    }
}
