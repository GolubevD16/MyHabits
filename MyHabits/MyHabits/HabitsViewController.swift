//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 25.12.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var myHabbitsView: MyHabbitsView = {
        myHabbitsView = MyHabbitsView()
        myHabbitsView.toAutoLayout()
        
        return myHabbitsView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        setupNavBar()
    }
    
    private func setupNavBar(){
        navigationController?.navigationBar.tintColor = InfoRes.purpleColor

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func addHabit() {
            let habitVc = HabitViewController()
            let navHabit = UINavigationController(rootViewController: habitVc)
            updateNavBarAppearance(navController: navHabit)
            navHabit.navigationBar.prefersLargeTitles = false
            habitVc.navigationItem.title = "Создать"
            navHabit.modalPresentationStyle = .fullScreen
            present(navHabit, animated: true, completion: nil)
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
