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
        view.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.1584289074, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
}
