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
        tableView.toAutoLayout()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        setupNav()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: HabRes.tableId)
        tableView.dataSource = self
        tableView.delegate = self
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = habit?.name
    }
    
    private func setupNav() {
        navigationController?.navigationBar.tintColor = .purple
        navigationItem.largeTitleDisplayMode = .never
        
        let rightBarButtonItem = UIBarButtonItem(title: HabRes.rightBarButtonItemText, style: .plain, target: self, action:#selector(openEditScreen))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    
    @objc func openEditScreen() {
        guard let habit = habit else { return }

        let habitVc = HabitViewController()
        let navHabit = UINavigationController(rootViewController: habitVc)
        habitVc.habit = habit
        navHabit.navigationBar.prefersLargeTitles = false
        habitVc.navigationItem.title = HabRes.nagigationTitle
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

extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        HabRes.titleForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabRes.tableId, for: indexPath) as? TableViewCell else {
            fatalError()
        }
        let ind = HabitsStore.shared.dates.count - indexPath.row - 1
        guard let habit = habit else { fatalError() }
        let date = HabitsStore.shared.dates[ind]
        cell.checkImageView.isHidden = !HabitsStore.shared.habit(habit, isTrackedIn: date)
        guard let dateString = HabitsStore.shared.trackDateString(forIndex: ind) else { fatalError() }
        cell.dateLabel.text = dateString
        cell.isSelected = false
        
        return cell
    }
}
