//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

protocol TrackerViewModelProtocol {
    // MARK: Handles
    var fetchCompleteHandle: (() -> Void)? { get set }
    var tapEditContextMenuHandler: ((_ tracker: Tracker) -> Void)? { get set }

    // MARK: Methods
    func fetch()
    func findCategory(_ indexPath: IndexPath) -> TrackerCategory
    func findTracker(_ indexPath: IndexPath) -> Tracker
    func completeTracker(_ tracker: Tracker, completedAt: Date) -> TrackerRecord
    func numberOfCategories() -> Int
    func numberOfTrackers(by: Int) -> Int
    func numberOfCompleteTracker(_ indexPath: IndexPath) -> Int

    func contextMenu(tracker: Tracker) -> UIMenu
}
