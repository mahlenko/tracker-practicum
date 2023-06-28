//
// Created by Сергей Махленко on 28.06.2023.
//

import UIKit

struct Tracker {
    let id: UUID
    let symbol: String
    let title: String
    let pin: Bool
    let color: UIColor

    func contextMenu() -> UIMenu {
        var lockAction: UIAction

        if pin {
            lockAction = UIAction(title: "Открепить") { _ in
                print("Unpin")
            }
        } else {
            lockAction = UIAction(title: "Закрепить") { _ in
                print("Pin")
            }
        }

        let editAction = UIAction(title: "Редактировать") { _ in
            print("Edit")
        }

        let deleteAction = UIAction(title: "Удалить", attributes: .destructive) { _ in
            print("Delete")
        }

        return UIMenu(title: "", children: [lockAction, editAction, deleteAction])
    }
}
