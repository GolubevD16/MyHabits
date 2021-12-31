//
//  HabitsViewControllerDelegate.swift
//  MyHabits
//
//  Created by a.agataev on 30.11.2021.
//

import Foundation

protocol HabitsViewControllerDelegate: AnyObject {
    func imageTapped(_ habit: Habit)
}
