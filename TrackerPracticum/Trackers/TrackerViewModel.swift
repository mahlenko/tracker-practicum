//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

final class TrackerViewModel: TrackerViewModelProtocol {
    private var categories: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []

    var fetchCompleteHandle: (() -> Void)?
    var tapEditContextMenuHandler: ((_ tracker: Tracker) -> Void)?

    func fetch() {
        categories.append(TrackerCategory(
            uuid: UUID(),
            name: "Радостные мелочи",
            items: fetchTrackers()))

        categories.append(TrackerCategory(
            uuid: UUID(),
            name: "Самочувствие",
            items: fetchTrackers()))

        categories.append(TrackerCategory(
            uuid: UUID(),
            name: "Домашний уют",
            items: fetchTrackers()))

        fetchCompleteHandle?()
    }

    func fetchTrackers() -> [Tracker] {
        let mock = TrackerMock()
        let randomItems = Int.random(in: 0..<5)

        var items: [Tracker] = []
        for _ in 0..<randomItems {
            items.append(mock.make())
        }

        return items
    }

    func findCategory(_ indexPath: IndexPath) -> TrackerCategory {
        categories[indexPath.section]
    }

    func findTracker(_ indexPath: IndexPath) -> Tracker {
        findCategory(indexPath).items[indexPath.row]
    }

    func completeTracker(_ tracker: Tracker, completedAt: Date) -> TrackerRecord {
        // TODO: - запретить отмечать на будущую дату
        let record = TrackerRecord(uuid: UUID(), tracker: tracker.uuid, date: completedAt)
        completedTrackers.append(record)
        return record
    }

    func numberOfCategories() -> Int {
        categories.count
    }

    func numberOfTrackers(by: Int) -> Int {
        categories[by].items.count
    }

    func numberOfCompleteTracker(_ indexPath: IndexPath) -> Int {
        let tracker = findTracker(indexPath)

        return completedTrackers.filter { record in
            record.tracker == tracker.uuid
        }.count
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
            tapEditContextMenuHandler?(tracker)
        }

        let deleteAction = UIAction(title: "Удалить", attributes: .destructive) { _ in
            print("Delete")
        }

        return UIMenu(title: "", children: [lockAction, editAction, deleteAction])
    }
}
