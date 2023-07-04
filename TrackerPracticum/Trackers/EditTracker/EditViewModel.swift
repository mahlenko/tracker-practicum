//
// Created by Сергей Махленко on 04.07.2023.
//

import UIKit

struct SectionItems {
    let name: String
    let cell: ReusableCell.Type
    let items: [Any]
}

class EditViewModel {
    static let emoji = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]

    static let colors = [
        UIColor.rgba(253, 76, 73, 1),
        UIColor.rgba(255, 136, 30, 1),
        UIColor.rgba(0, 123, 250, 1),
        UIColor.rgba(110, 68, 254, 1),
        UIColor.rgba(51, 207, 105, 1),
        UIColor.rgba(230, 109, 212, 1),
        UIColor.rgba(249, 212, 212, 1),
        UIColor.rgba(52, 167, 254, 1),
        UIColor.rgba(70, 230, 157, 1),
        UIColor.rgba(53, 52, 124, 1),
        UIColor.rgba(255, 103, 77, 1),
        UIColor.rgba(255, 153, 204, 1),
        UIColor.rgba(246, 196, 139, 1),
        UIColor.rgba(121, 148, 245, 1),
        UIColor.rgba(131, 44, 241, 1),
        UIColor.rgba(173, 86, 218, 1),
        UIColor.rgba(141, 114, 230, 1),
        UIColor.rgba(47, 208, 88, 1)
    ]

    lazy var sections: [SectionItems] = {
        [
            SectionItems(name: "Emoji", cell: EmojiCell.self, items: EditViewModel.emoji),
            SectionItems(name: "Цвет", cell: ColorCell.self, items: EditViewModel.colors)
        ]
    }()
}
