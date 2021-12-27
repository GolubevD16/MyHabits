//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 26.12.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit?
    
    lazy var scrollView:UIScrollView = {
        scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    lazy var habitView: HabitView = {
        habitView = HabitView()
        habitView.toAutoLayout()
        
        return habitView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupView()
        registerForKeyboardNotification()
    }
    
    deinit{
        removeForKeyboardNotification()
    }
    
    private func setupView(){
        scrollView.addSubview(habitView)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            habitView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            habitView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            habitView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            habitView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            habitView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleColorSelection))
        habitView.colorView.addGestureRecognizer(gesture)
        habitView.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
    }
    
    private func setupNavBar(){
        navigationController?.navigationBar.tintColor = InfoRes.purpleColor
                
        let leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
                
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func configure(with habit: Habit) {
        self.habit = habit
        habitView.textView.text = habit.name
        habitView.colorView.backgroundColor = habit.color
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        habitView.dateLabel.text = formatter.string(from: habit.date)
        habitView.datePicker.date = habit.date
        //deleteButton.isHidden = false
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        guard let nameText = habitView.textView.text, !nameText.isEmpty else { return }
        if let habit = habit{
            print(habit)
        }else{
            let newHabit = Habit(
                name: nameText,
                date: habitView.datePicker.date,
                color: habitView.colorView.backgroundColor ?? UIColor.orange
            )
            
            HabitsStore.shared.habits.append(newHabit)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleColorSelection() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.selectedColor = habitView.colorView.backgroundColor ?? .green
        present(colorPickerVC, animated: true)
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.string(from: habitView.datePicker.date)
        habitView.dateLabel.text = formatter.string(from: habitView.datePicker.date)
    }
    
    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    private func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let scrolSize = self.habitView.datePicker.frame.maxY + keyboardSize.height - self.view.bounds.maxY + 8 + self.view.safeAreaInsets.top
        scrollView.contentSize = CGSize(width: habitView.bounds.width, height: habitView.bounds.height + scrolSize)
        scrollView.contentOffset = CGPoint(x: 0, y: 22)
        scrollView.isScrollEnabled = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentSize = CGSize(width: habitView.bounds.width, height: habitView.bounds.height - keyboardSize.height)
        scrollView.isScrollEnabled = false
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        habitView.colorView.backgroundColor = color
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        habitView.colorView.backgroundColor = color
    }
}
