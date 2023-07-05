//
// Created by Сергей Махленко on 05.07.2023.
//

import UIKit

final class TableAdvancedViewCell: UITableViewCell, ReusableCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .asset(.background).withAlphaComponent(0)
        accessoryType = .disclosureIndicator

        textLabel?.font = .systemFont(ofSize: 17)
        detailTextLabel?.font = .systemFont(ofSize: 17)
        detailTextLabel?.textColor = .asset(.grayUniversal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
