//
//  TableViewCell.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 28.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var dateLabel: UILabel = {
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        dateLabel.toAutoLayout()
        
        return dateLabel
    }()
    
    lazy var checkImageView: UIImageView = {
        checkImageView = UIImageView(image: UIImage(systemName: "checkmark"))
        checkImageView.toAutoLayout()
        checkImageView.isHidden = true
        
        return checkImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([dateLabel, checkImageView])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            checkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
        ])
    }

}
