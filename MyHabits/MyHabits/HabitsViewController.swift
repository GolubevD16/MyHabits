//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 25.12.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .systemGray6
        collectionView.toAutoLayout()
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
        setupNavBar()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }
    
    private func setupNavBar(){
        navigationController?.navigationBar.tintColor = InfoRes.purpleColor

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func addHabit() {
            let habitVc = HabitViewController()
            let navHabit = UINavigationController(rootViewController: habitVc)
            updateNavBarAppearance(navController: navHabit)
            navHabit.navigationBar.prefersLargeTitles = false
        habitVc.navigationItem.title = HabRes.createNagigationTitle
            navHabit.modalPresentationStyle = .fullScreen
            present(navHabit, animated: true, completion: nil)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: section) else { return nil }
            
            switch sectionKind {
            case .progress:
                return self.progressCollectionLayoutSection()
            case .main:
                return self.mainCollectionLayoutSection()
            }
        }
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

extension HabitsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let habitDetailsVc = HabitDetailViewController()
            
            var habs = HabitsStore.shared.habits
            habs = habs.sorted(by: { hab1, hab2 in
                hab1.dateString < hab2.dateString
            })
            
            let habit = habs[indexPath.item]
            habitDetailsVc.habit = habit
            habitDetailsVc.navigationItem.title = habit.name
            navigationController?.pushViewController(habitDetailsVc, animated: true)
        }
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionKind = Section(rawValue: section) else { return 0 }
        
        switch sectionKind {
        case .progress:
            return 1
        case .main:
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionKind = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }

        switch sectionKind {
        case .progress:
            return collectionViewCell(section: .progress, cellForItemAt: indexPath)
        case .main:
            return collectionViewCell(section: .main, cellForItemAt: indexPath)
        }
    }
}


extension HabitsViewController {
    enum Section: Int, CaseIterable  {
        case progress = 0
        case main = 1
    }
    
    func collectionViewCell(section: Section, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch section {
        case .progress:
            return progressCollectionViewCell(cellForItemAt: indexPath)
        case .main:
            return mainCollectionViewCell(cellForItemAt: indexPath)
        }
    }
    
    func progressCollectionLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 22, leading: 16, bottom: 18, trailing: 17)
        
        return section
    }
    
    func mainCollectionLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 17)
        section.interGroupSpacing = 12
        
        return section
    }
    
    func progressCollectionViewCell(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as? ProgressCollectionViewCell else { return ProgressCollectionViewCell() }
        
        cell.configure(with: HabitsStore.shared.todayProgress)
        
        return cell
    }
    
    func mainCollectionViewCell(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
        var habs = HabitsStore.shared.habits
        habs = habs.sorted(by: { hab1, hab2 in
            hab1.dateString < hab2.dateString
        })
        let habit = habs[indexPath.item]
        cell.configure(with: habit)
        cell.delegate = self
        
        return cell
    }
}


extension HabitsViewController: HabitsViewControllerDelegate {
    func imageTapped(_ habit: Habit) {
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            
            collectionView.reloadData()
        }
    }
}
