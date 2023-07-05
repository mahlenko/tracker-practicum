//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

class TrackerViewController: UIViewController, TrackerViewDelegateProtocol {
    var viewModel: TrackerViewModelProtocol = TrackerViewModel()

    // MARK: - UI

    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(showCreateTracker))

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

    private lazy var emptyStackView: UIStackView = {
        EmptyDataStackView(
            image: .asset(.emptyListIcon),
            message: "Что будем отслеживать?")
    }()

    // MARK: - Setup view

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        bindToUpdate()

        viewModel.fetch()

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let editController = EditTrackerViewController()
            let navigationController = UINavigationController(rootViewController: editController)
            present(navigationController, animated: true)
        }
    }

    private func setupView() {
        navigationItem.leftBarButtonItem = plusButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchBarController

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrackerViewCell.self, forCellWithReuseIdentifier: TrackerViewCell.identifier)
        collectionView.register(
            CollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionHeaderView.identifier)

        view.addSubview(collectionView)
        view.addSubview(emptyStackView)
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        [emptyStackView, collectionView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        if let emptyStackView = emptyStackView as? EmptyDataStackView {
            emptyStackView.setupLayout(safeArea: safeArea)
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        ])
    }
}

// MARK: - Actions

extension TrackerViewController {
    @objc func showCreateTracker(_ sender: Any) {
        let controller = SelectTrackerTypeViewContoller()
        let navigationBar = UINavigationController(rootViewController: controller)
        present(navigationBar, animated: true)
    }

    /// Binding handlers for view model
    func bindToUpdate() {
        // Fetch complete
        viewModel.fetchCompleteHandle = { [weak self] in
            guard let self else { return }
            emptyStackView.isHidden = viewModel.numberOfCategories() > 0
        }

        // Edit action for context menu
        viewModel.tapEditContextMenuHandler = { [weak self] (tracker: Tracker) in
            guard let self else { return }

            let editController = EditTrackerViewController(tracker: tracker, isRegular: tracker.isRegular)
            let navigationController = UINavigationController(rootViewController: editController)

            present(navigationController, animated: true)
        }
    }
}

// MARK: Extensions

extension TrackerViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: 50.0)
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

            let category = viewModel.findCategory(indexPath)
            headerView.setup(title: category.name)

            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth / 2 - 4.5, height: 148)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfCategories()
    }
}

extension TrackerViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.numberOfTrackers(by: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerViewCell.identifier,
            for: indexPath) as? TrackerViewCell
        else { fatalError("Reusable cell not found.") }

        cell.delegate = self

        let tracker = viewModel.findTracker(indexPath)
        cell.setup(for: tracker)

        return cell
    }
}
