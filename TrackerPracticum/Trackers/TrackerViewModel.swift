//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

class TrackerViewModel: TrackerViewModelProtocol {
    private var items: [Tracker] = []

    lazy var countItems: Int = {
        items.count
    }()

    var fetchCompleteHandle: (() -> Void)?
    var editTrackerHandle: ((_: Tracker) -> Void)?

    func fetchTrackers() {
        // TODO: Using storage
        let trackerMock = TrackerMock()

        for _ in 0..<Int.random(in: 0..<15) {
            items.append(trackerMock.make())
        }

        fetchCompleteHandle?()
    }

    func tracker(by: Int) -> Tracker? {
        by <= items.count ? items[by] : nil
    }

    func contextMenu(tracker: Tracker) -> UIMenu {
        var lockAction: UIAction

        if tracker.pin {
            lockAction = UIAction(title: "Открепить") { _ in
                print("Unpin")
            }
        } else {
            lockAction = UIAction(title: "Закрепить") { _ in
                print("Pin")
            }
        }

        let editAction = UIAction(title: "Редактировать") { [weak self] _ in
            guard let self else { return }
            self.editTrackerHandle?(tracker)
        }

        let deleteAction = UIAction(title: "Удалить", attributes: .destructive) { _ in
            print("Delete")
        }

        return UIMenu(title: "", children: [lockAction, editAction, deleteAction])
    }
}
