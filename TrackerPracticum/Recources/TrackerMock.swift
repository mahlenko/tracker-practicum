//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

class TrackerMock {
    private let symbols: [String] = [
        "🍇", "🍈", "🍉", "🍊", "🍋",
        "🍌", "🍍", "🥭", "🍎", "🍏",
        "🍐", "🍒", "🍓", "🫐", "🥝",
        "🍅", "🫒", "🥥", "🥑", "🍆",
        "🥔", "🥕", "🌽", "🌶️", "🫑",
        "🥒", "🥬", "🥦", "🧄", "🧅",
        "🍄"
    ]

    private let titles: [String] = [
        "Кошка заслонила камеру на созвоне",
        "Поливать растения",
        "Бабушка прислала открытку в вотсапе",
        "Свидания в апреле",
        "Хорошее настроение",
        "Легкая тревожность"
    ]

    private let colors: [UIColor] = [
        .asset(.redUniversal),
        .asset(.blueUniversal)
    ]

    func make() -> Tracker {
        Tracker(
            id: UUID(),
            symbol: symbols.randomElement() ?? "",
            title: titles.randomElement() ?? "unknown",
            pin: Bool.random(),
            color: colors.randomElement() ?? .asset(.lightGrayUniversal))
    }
}
