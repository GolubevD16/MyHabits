//
//  UIView-extension.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 25.12.2021.
//

import UIKit

public extension UIView {
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
}
