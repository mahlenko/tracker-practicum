//
// Created by Сергей Махленко on 07.06.2023.
//

import UIKit

class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTabs()
    }

    private func setupView() {
        tabBar.isTranslucent = true
        tabBar.barTintColor = .systemGroupedBackground
        tabBar.tintColor = .asset(.blueUniversal)
    }

    private func setupTabs() {
        // First tab "Trackers"
        let trackerController = TrackerViewController()
        trackerController.title = "Трекеры"

        let trackerNavigationController = UINavigationController(rootViewController: trackerController)
        trackerNavigationController.navigationBar.prefersLargeTitles = true
        trackerNavigationController.view.backgroundColor = .asset(.white)
        trackerNavigationController.tabBarItem = UITabBarItem(
            title: trackerController.title,
            image: UIImage(systemName: "record.circle.fill"),
            tag: 0)

        // Second tab "Statistic"
        let statisticController = StatisticScreenController()
        statisticController.title = "Статистика"

        let statisticNavigationController = UINavigationController(rootViewController: statisticController)
        statisticNavigationController.navigationBar.prefersLargeTitles = true
        statisticNavigationController.view.backgroundColor = .asset(.white)
        statisticNavigationController.tabBarItem = UITabBarItem(
            title: statisticController.title,
            image: UIImage(systemName: "hare.fill"),
            tag: 1)

        viewControllers = [
            trackerNavigationController,
            statisticNavigationController
        ]
    }
}
