//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

final class SelectTrackerTypeViewContoller: UIViewController {
    private lazy var regularButton: Button = {
        let button = Button(type: .custom)
        button.setTitle("Привычка", for: .normal)
        return button
    }()

    private lazy var notRegularButton: Button = {
        let button = Button(type: .custom)
        button.setTitle("Нерегулярное событие", for: .normal)
        return button
    }()

    private lazy var actionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [regularButton, notRegularButton])
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    private func setupView() {
        title = "Создание трекера"
        view.backgroundColor = .asset(.white)
        view.addSubview(actionStackView)

        regularButton.addTarget(self, action: #selector(regularTap), for: .touchUpInside)
        notRegularButton.addTarget(self, action: #selector(notRegularTap), for: .touchUpInside)
    }

    private func setupLayout() {
        actionStackView.translatesAutoresizingMaskIntoConstraints = false

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            actionStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            actionStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            actionStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            actionStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
}

// MARK: - Actions

extension SelectTrackerTypeViewContoller {
    @objc func regularTap() {
        let editController = EditTrackerViewController(tracker: nil, isRegular: true)
        return showEditController(root: editController)
    }

    @objc func notRegularTap() {
        let editController = EditTrackerViewController(tracker: nil, isRegular: false)
        return showEditController(root: editController)
    }

    private func showEditController(root: UIViewController) {
        let navigationController = UINavigationController(rootViewController: root)
        present(navigationController, animated: true)
    }
}
