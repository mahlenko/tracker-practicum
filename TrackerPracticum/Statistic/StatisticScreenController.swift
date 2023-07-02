//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

final class StatisticScreenController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layoutFlow = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)

        collection.delegate = self
        collection.dataSource = self
        collection.register(StatisticViewCell.self, forCellWithReuseIdentifier: StatisticViewCell.identifier)
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
    }

    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(emptyStackView)
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        if let emptyStackView = emptyStackView as? EmptyDataStackView {
            emptyStackView.setupLayout(safeArea: safeArea)
        }

//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
//        ])
    }
}

extension StatisticScreenController: UICollectionViewDelegate {
}

extension StatisticScreenController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StatisticViewCell.identifier,
            for: indexPath)

        print(indexPath.row)

        return cell
    }
}
