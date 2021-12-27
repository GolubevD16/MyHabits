//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 27.12.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var delegate: HabitsViewControllerDelegate?
    var habit: Habit?
        
    static var identifier: String {
        return String(describing: self)
    }
            
    lazy var habitNameLabel: UILabel = {
        habitNameLabel = UILabel(frame: .zero)
        habitNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        habitNameLabel.textColor = .systemGray2
        habitNameLabel.numberOfLines = 2
        habitNameLabel.toAutoLayout()
        
        return habitNameLabel
    }()
    
    lazy var habitDateLabel: UILabel = {
        habitDateLabel = UILabel(frame: .zero)
        habitDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        habitDateLabel.textColor = .systemGray2
        habitDateLabel.toAutoLayout()
        
        return habitDateLabel
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView(arrangedSubviews: [habitNameLabel, habitDateLabel])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    lazy var habitCountTrackLabel: UILabel = {
        habitCountTrackLabel = UILabel(frame: .zero)
        habitCountTrackLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        habitCountTrackLabel.textColor = .systemGray
        habitCountTrackLabel.toAutoLayout()
        
        return habitCountTrackLabel
    }()
    
    lazy var habitCheckImageView: UIImageView = {
        habitCheckImageView = UIImageView(frame: .zero)
        habitCheckImageView.backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTappedImageView))
        habitCheckImageView.addGestureRecognizer(gesture)
        habitCheckImageView.isUserInteractionEnabled = true
        habitCheckImageView.toAutoLayout()
        
        return habitCheckImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([
            stackView,
            habitCountTrackLabel,
            habitCheckImageView
        ])
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupView()
        setupLayout()
    }
    
    //MARK: - configure cell
    
    func configure(with habit: Habit) {
        self.habit = habit
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitDateLabel.text = habit.dateString
        habitCountTrackLabel.text = "Счетчик:  \(habit.trackDates.count)"
        let checkImage = habit.isAlreadyTakenToday ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        habitCheckImageView.image = checkImage
        habitCheckImageView.tintColor = habit.color
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    //MARK: - setup constraints
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103),
            
            habitCountTrackLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            habitCountTrackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            habitCheckImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            habitCheckImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            habitCheckImageView.widthAnchor.constraint(equalToConstant: 36),
            habitCheckImageView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    @objc func handleTappedImageView() {
        guard let habit = habit else { return }
        delegate?.imageTapped(habit)
    }
}
