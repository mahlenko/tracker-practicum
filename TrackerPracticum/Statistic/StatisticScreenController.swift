//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

final class StatisticScreenController: UIViewController {
    private let viewModel = StatisticViewModel()

    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.backgroundColor = .asset(.white)
        return collection
    }()

    private lazy var emptyStackView: UIStackView = {
        EmptyDataStackView(
            image: .asset(.emptyStatisticIcon),
            message: "Анализировать пока нечего")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.fetchCompleteHandle = { [weak self] in
            guard let self else { return }
            self.emptyStackView.isHidden = viewModel.hasData

            collectionView.reloadData()
        }

        viewModel.fetch()
    }

    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(emptyStackView)

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(StatisticViewCell.self, forCellWithReuseIdentifier: StatisticViewCell.identifier)
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        if let emptyStackView = emptyStackView as? EmptyDataStackView {
            emptyStackView.setupLayout(safeArea: safeArea)
        }

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        ])
    }
}

extension StatisticScreenController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        12
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: 90)
    }
}

extension StatisticScreenController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StatisticViewCell.identifier,
            for: indexPath) as? StatisticViewCell
        else { fatalError("Reusable cell not found.") }

        if let statisticItem = viewModel.data(by: indexPath.row) {
            cell.setup(for: statisticItem)
        }

        return cell
    }
}
