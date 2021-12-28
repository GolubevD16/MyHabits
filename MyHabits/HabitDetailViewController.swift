//
//  HabitDetailViewController.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 28.12.2021.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    var habit: Habit?
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .lightGray
        tableView.toAutoLayout()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = habit?.name
    }
    
    private func setupNav() {
        navigationController?.navigationBar.tintColor = .purple
        navigationItem.largeTitleDisplayMode = .never
        
        let rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action:#selector(openEditScreen))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    @objc func openEditScreen() {
        guard let habit = habit else { return }

        let habitVc = HabitViewController()
        let navHabit = UINavigationController(rootViewController: habitVc)
        habitVc.habit = habit
        navHabit.navigationBar.prefersLargeTitles = false
        habitVc.navigationItem.title = "Редактировать"
        habitVc.habitView.configure(with: habit)
        habitVc.delegate = self
        navHabit.modalPresentationStyle = .fullScreen
        present(navHabit, animated: true, completion: nil)
    }
}

extension HabitDetailViewController: CloseDelegate{
    func close() {
        navigationController?.popViewController(animated: true)
    }
}
