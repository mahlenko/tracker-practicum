//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

class TrackerMock {
    private let colors: [UIColor] = SectionRepository.colors
    private let symbols: [String] = SectionRepository.emoji

    func make() -> Tracker {
        Tracker(
            uuid: UUID(),
            symbol: symbols.randomElement() ?? "",
            title: [
                "Кошка заслонила камеру на созвоне",
                "Поливать растения",
                "Бабушка прислала открытку в вотсапе",
                "Свидания в апреле",
                "Хорошее настроение",
                "Легкая тревожность"
            ].randomElement() ?? "unknown",
            pin: Bool.random(),
            color: colors.randomElement() ?? .asset(.lightGrayUniversal),
            isRegular: Bool.random())
    }
}
