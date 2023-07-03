//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

protocol TrackerViewModelProtocol {
    var count: Int { get }

    var editTrackerHandle: ((_: Tracker) -> Void)? { get set }
    var fetchCompleteHandle: (() -> Void)? { get set }

    func fetchTrackers()
    func tracker(by: Int) -> Tracker?

    func contextMenu(tracker: Tracker) -> UIMenu
}
