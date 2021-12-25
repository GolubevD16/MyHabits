//
//  InfoView.swift
//  MyHabits
//
//  Created by Дмитрий Голубев on 25.12.2021.
//

import UIKit

class InfoView: UIView {
    lazy var stackView: UIStackView = {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    lazy var textTitle: UILabel = {
        textTitle = UILabel()
        textTitle.text = InfoRes.title
        textTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        textTitle.toAutoLayout()
        
        return textTitle
    }()
    
    lazy var textView: UITextView = {
        textView = UITextView()
        textView.text = InfoRes.text
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.toAutoLayout()
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(textTitle)
        stackView.addArrangedSubview(textView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                        
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            
        ])
    }
    
}
