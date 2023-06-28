//
// Created by Сергей Махленко on 28.06.2023.
//

import Foundation

class TrackerViewModel {
    var items: [Tracker] = []

    lazy var count: Int = {
        items.count
    }()

    func fetchTrackers() {
        // TODO: Using storage
        let trackerMock = TrackerMock()

        for _ in 0..<Int.random(in: 5..<15) {
            items.append(trackerMock.make())
        }
    }

    func item(by: Int) -> Tracker {
        items[by]
    }
}
