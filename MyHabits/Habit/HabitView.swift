//
//  HabitView.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 26.12.2021.
//

import UIKit

class HabitView: UIView {
    
    lazy var firstLabel: UILabel = {
        firstLabel = UILabel()
        firstLabel.text = "Название"
        firstLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        firstLabel.toAutoLayout()
        
        return firstLabel
    }()
    
    lazy var textView: UITextField = {
        textView = UITextField()
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.textColor = .black
        textView.placeholder = "что-то"
        textView.toAutoLayout()
        
        return textView
    }()
    
    lazy var secondLabel: UILabel = {
        secondLabel = UILabel()
        secondLabel.text = "Цвет"
        secondLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
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
        thirdLabel.text = "Дата"
        thirdLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        thirdLabel.toAutoLayout()
        
        return thirdLabel
    }()
    
    lazy var timeLabel: UILabel = {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        timeLabel.text = "Каждый день в "
        timeLabel.toAutoLayout()
        
        return timeLabel
    }()
    
    lazy var dateLabel: UILabel = {
        dateLabel = UILabel()
        dateLabel.textColor = InfoRes.purpleColor
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        var time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubviews([firstLabel, textView, secondLabel, colorView, thirdLabel, timeLabel, datePicker, dateLabel])
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
        ])
    }
}
