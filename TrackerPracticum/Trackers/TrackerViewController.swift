//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

class TrackerViewController: UIViewController {
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

    private var searchBar: UISearchController = {
        let searchController = UISearchController()
        searchController.automaticallyShowsCancelButton = true
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
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
    }

    private func setupView() {
        navigationItem.leftBarButtonItem = plusButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchBar

        view.addSubview(emptyStackView)
        // TODO: add collection
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        emptyStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emptyStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emptyStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            emptyStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            emptyStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
}
