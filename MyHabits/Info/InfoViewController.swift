//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 25.12.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var infoView: InfoView = {
        infoView = InfoView()
        infoView.toAutoLayout()
        
        return infoView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout(){
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
