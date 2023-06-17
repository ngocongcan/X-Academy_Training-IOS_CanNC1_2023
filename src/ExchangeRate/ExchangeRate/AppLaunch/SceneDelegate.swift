//
//  SceneDelegate.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 05/06/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        createTabbar(windowScene: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

private extension SceneDelegate {
    func createTabbar(windowScene: UIWindowScene) {
        // Create an instance of XATTabBarController
        let tabBarController = XATTabBarController()

        // Create view controllers for each tab
        let exchangeRateVC = ExchangeRateViewController()
        exchangeRateVC.viewModel = ExchangeRateViewModel()
        let exchangeRateNavi = UINavigationController(rootViewController: exchangeRateVC)
        exchangeRateNavi.tabBarItem = UITabBarItem(title: "Tỉ VÀNG", image: #imageLiteral(resourceName: "icons_money"), tag: 0)

        let goldPriceVC = GoldPriceController()
        goldPriceVC.viewModel = GoldPriceViewModel()
        let goldPriceNavi = UINavigationController(rootViewController: goldPriceVC)
        goldPriceNavi.tabBarItem = UITabBarItem(title: "GIÁ VÀNG", image: #imageLiteral(resourceName: "icons_average_price"), tag: 1)

        let chartVC = ChartViewController()
        let chartNavi = UINavigationController(rootViewController: chartVC)
        chartNavi.tabBarItem = UITabBarItem(title: "BIỂU ĐỒ", image: #imageLiteral(resourceName: "icons_chart"), tag: 2)

        let accountVC = AccountViewController()
        let accountNavi = UINavigationController(rootViewController: accountVC)
        accountNavi.tabBarItem = UITabBarItem(title: "VỀ CHÚNG TÔI", image: #imageLiteral(resourceName: "icons_3_dots"), tag: 3)

        // Set the view controllers for the tab bar controller
        tabBarController.viewControllers = [exchangeRateNavi, goldPriceNavi, chartNavi, accountNavi]
        tabBarController.tabBar.backgroundColor = ThemeColor.tabBarBackgroundColor
        tabBarController.tabBar.tintColor = ThemeColor.tabarTintColor
        tabBarController.tabBar.barTintColor = .white

        // Create a UIWindow using the windowScene
        window = UIWindow(windowScene: windowScene)

        // Set the root view controller of the window to be the tab bar controller
        window?.rootViewController = tabBarController

        // Make the window visible
        window?.makeKeyAndVisible()
    }
}
