//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

class TrackerViewController: UIViewController {
    private let viewModel = TrackerViewModel()

    // MARK: - UI

    private var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"))
        button.tintColor = .asset(.black)
        return button
    }()

    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()

    private var searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.automaticallyShowsCancelButton = true
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()

    private var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.backgroundColor = .asset(.white)
        return collection
    }()

    private var emptyStackView: UIStackView = {
        let image = UIImageView(image: .asset(.emptyList))

        let messageLabel = UILabel()
        messageLabel.text = "Что будем отслеживать?"
        messageLabel.textColor = .asset(.black)
        messageLabel.textAlignment = .center
        messageLabel.font = .boldSystemFont(ofSize: 12)

        let stackView = UIStackView(arrangedSubviews: [image, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center

        return stackView
    }()

    // MARK: - Setup view

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()

        viewModel.fetchTrackers()
    }

    private func setupView() {
        navigationItem.leftBarButtonItem = plusButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchBarController

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrackerViewCell.self, forCellWithReuseIdentifier: TrackerViewCell.identifier)

        view.addSubview(emptyStackView)
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        [emptyStackView, collectionView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            emptyStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emptyStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            emptyStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            emptyStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        ])
    }
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        9
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        9
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth / 2 - 4.5, height: 148)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TrackerViewCell
        else { return nil }

        let tracker = viewModel.item(by: indexPath.row)

        // TODO: при нажатии обрезается часть карточки + позиционирование превью не по верхнему краю
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: {
                // setup preview view
                let cart = TrackerCartView()

                cart.setup(
                    for: tracker,
                    preferredContentSize: cell.cartView.view.bounds.size
                )

                return cart
            },
            actionProvider: { _ in
                tracker.contextMenu()
            }
        )
    }
}

extension TrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerViewCell.identifier,
            for: indexPath) as! TrackerViewCell

        let tracker = viewModel.item(by: indexPath.row)
        cell.setup(for: tracker)

        return cell
    }
}
