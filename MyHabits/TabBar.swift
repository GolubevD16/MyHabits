//
//  TabBar.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 25.12.2021.
//

import UIKit

class TabBar: UITabBarController {
    
    private enum Constans {
        static let myHabitsTitle: String = "Сегодня"
        static let myHabitsTabBarTitle: String = "Привычки"
        static let infoTitle: String = "Информация"
        static let myHabitsImageName: String = "rectangle.grid.1x2.fill"
        static let infoImageName: String = "info.circle.fill"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTabBar()
        updateTabBarAppearance()
    }
    
    func setUpTabBar(){
        viewControllers = [createNavigationController(for: HabitsViewController(),
                                                        title: Constans.myHabitsTitle,
                                                        tabBratTitle: Constans.myHabitsTabBarTitle,
                                                        image: UIImage(systemName:                                                               Constans.myHabitsImageName) ??                                 UIImage()),
                           createNavigationController(for: InfoViewController(),
                                                         title: Constans.infoTitle,
                                                         tabBratTitle: Constans.infoTitle,
                                                         image: UIImage(systemName: Constans.infoImageName) ?? UIImage())
        ]
        self.tabBar.tintColor = InfoRes.purpleColor
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            tabBratTitle: String,
                                            image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.topViewController?.title = title
        navController.tabBarItem.title = tabBratTitle
        updateNavBarAppearance(navController: navController)
        return navController
    }
    
    @available(iOS 15.0, *)
    private func updateTabBarAppearance() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        
        let barTintColor: UIColor = .white
        tabBarAppearance.backgroundColor = barTintColor
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    @available(iOS 15.0, *)
    private func updateNavBarAppearance(navController: UINavigationController) {
        let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        let navTintColor: UIColor = .white
        navBarAppearance.backgroundColor = navTintColor
        
        navController.navigationBar.standardAppearance = navBarAppearance
        navController.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

}
