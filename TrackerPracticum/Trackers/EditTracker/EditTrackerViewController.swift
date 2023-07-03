//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

final class EditTrackerViewController: UIViewController {
    private let isRegular: Bool
    private let tracker: Tracker?

    init(tracker: Tracker?, isRegular: Bool = false) {
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
    }

    private func setupView() {
        view.backgroundColor = .asset(.white)

        title = tracker == nil
            ? "Новая привычка"
            : "Редактирование привычки"
    }
}
