//
// Created by Сергей Махленко on 02.07.2023.
//

import Foundation

class StatisticViewModel {
    var fetchCompleteHandle: (() -> Void)?

    private var items: [StatisticItem] = []

    lazy var count: Int = {
        items.count
    }()

    lazy var hasData: Bool = {
        !items.isEmpty
    }()

    func fetch() {
        createItems()
        fetchCompleteHandle?()
    }

    func data(by: Int) -> StatisticItem? {
        by <= items.count ? items[by] : nil
    }

    private func createItems() {
        items.append(StatisticItem(title: "Лучший период", value: 6))
        items.append(StatisticItem(title: "Идеальные дни", value: 2))
        items.append(StatisticItem(title: "Трекеров завершено", value: 5))
        items.append(StatisticItem(title: "Среднее значение", value: 4))
    }
}
