//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 27.12.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
            
    lazy var statusLabel: UILabel = {
        statusLabel = UILabel(frame: .zero)
        statusLabel.font = HabRes.regular13
        statusLabel.textColor = .systemGray
        statusLabel.toAutoLayout()
        
        return statusLabel
    }()
    
    lazy var procentLabel: UILabel = {
        procentLabel = UILabel(frame: .zero)
        procentLabel.font = HabRes.regular13
        procentLabel.textColor = .systemGray
        procentLabel.toAutoLayout()
        
        return procentLabel
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView(arrangedSubviews: [statusLabel, procentLabel])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    lazy var progressView: UIProgressView = {
        progressView = UIProgressView(frame: .zero)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 3.5
        progressView.progressTintColor = .purple
        progressView.progressViewStyle = .bar
        progressView.backgroundColor = HabRes.grayColor
        progressView.toAutoLayout()
        
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([
            stackView,
            progressView
        ])
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
    
    func configure(with progress: Float) {
        statusLabel.text = stateText(with: progress)
        procentLabel.text = "\(toProcent(with: progress)) %"
        progressView.progress = progress
    }

    func stateText(with progress: Float) -> String {
        switch progress {
        case 0..<0.5:
            return HabRes.firstStatus
        case 0.5..<1.0:
            return HabRes.secondStatus
        case 1.0...:
            return HabRes.doneStatus
        default:
            return "Ошибка"
        }
    }
    
    func toProcent(with progress: Float) -> Int {
        return Int(progress * 100)
    }
}

