//
//  HabitView.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 26.12.2021.
//

import UIKit

class HabitView: UIView {
    
    var habit: Habit?
    
    lazy var firstLabel: UILabel = {
        firstLabel = UILabel()
        firstLabel.text = HabRes.firstLabelText
        firstLabel.font = HabRes.semibold13
        firstLabel.toAutoLayout()
        
        return firstLabel
    }()
    
    lazy var textView: UITextField = {
        textView = UITextField()
        textView.font = HabRes.semibold17
        textView.textColor = .blue
        textView.tintColor = .blue
        textView.placeholder = HabRes.textViewPlaceholder
        textView.toAutoLayout()
        
        return textView
    }()
    
    lazy var secondLabel: UILabel = {
        secondLabel = UILabel()
        secondLabel.text = HabRes.secondLabelText
        secondLabel.font = HabRes.semibold13
        secondLabel.toAutoLayout()
        
        return secondLabel
    }()
    
    lazy var colorView: UIView = {
        colorView = UIView(frame: .zero)
        colorView.backgroundColor = .green
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = 15
        colorView.toAutoLayout()
        
        return colorView
    }()
    
    lazy var thirdLabel: UILabel = {
        thirdLabel = UILabel()
        thirdLabel.text = HabRes.thirdLabelText
        thirdLabel.font = HabRes.semibold13
        thirdLabel.toAutoLayout()
        
        return thirdLabel
    }()
    
    lazy var timeLabel: UILabel = {
        timeLabel = UILabel()
        timeLabel.font = HabRes.regular17
        timeLabel.text = HabRes.timeLabelText
        timeLabel.toAutoLayout()
        
        return timeLabel
    }()
    
    lazy var dateLabel: UILabel = {
        dateLabel = UILabel()
        dateLabel.textColor = InfoRes.purpleColor
        dateLabel.font = HabRes.regular17
        var time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = HabRes.dateFormat
        dateLabel.text = formatter.string(from: time)
        dateLabel.toAutoLayout()
        
        return dateLabel
    }()
    
    lazy var datePicker: UIDatePicker = {
        datePicker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.toAutoLayout()
        
        return datePicker
    }()
    
    lazy var deleteButton: UIButton = {
        deleteButton = UIButton()
        deleteButton.setTitle(HabRes.deleteButtonTitle, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.toAutoLayout()
        deleteButton.isHidden = true
        
        return deleteButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubviews([firstLabel, textView, secondLabel, colorView, thirdLabel, timeLabel, datePicker, dateLabel, deleteButton])
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            firstLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 22),
            
            textView.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 7),
            textView.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor),
            secondLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 15),
            
            colorView.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor),
            colorView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 7),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            thirdLabel.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor),
            thirdLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            
            timeLabel.leadingAnchor.constraint(equalTo: thirdLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: thirdLabel.bottomAnchor, constant: 7),
            
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            
            dateLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),
            
            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
        ])
    }
    
    func configure(with habit: Habit){
        self.habit = habit
        textView.text = habit.name
        colorView.backgroundColor = habit.color
        let time = habit.date
        let formatter = DateFormatter()
        formatter.dateFormat = HabRes.dateFormat
        dateLabel.text = formatter.string(from: time)
        datePicker.date = habit.date
        deleteButton.isHidden = false
    }
}
