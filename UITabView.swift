//
//  UITabView.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 03.11.2023.
//

import UIKit
import SwiftUI

class UITabView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .customDarkBlue
    }
    
    let viewModel = HomeViewModel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explorer"
        label.font = .markProFont(size: 17, weight: .heavy)
        label.textColor = .white
        return label
    }()
    
    
    private let circle : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return view
    }()
    
    lazy var bagButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "bagPic"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        button.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return button
    }()
    
    lazy var heartButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "heartPic"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        button.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return button
    }()
    
    lazy var profileButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "profilePic"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        button.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return button
    }()
    
    @objc func didTouchBagButton(navController: UINavigationController) {
        viewModel.goToCartController(navController: navController)
    }
    
}
    
    
private extension UITabView {
        
         func setupUI() {
            
            let labelsStack = UIStackView(arrangedSubviews: [circle, label])
            labelsStack.spacing = 7
            labelsStack.translatesAutoresizingMaskIntoConstraints = false
            labelsStack.alignment = .center
            labelsStack.distribution = .fillProportionally
            
            self.addSubview(labelsStack)
            
            labelsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45).isActive = true
            labelsStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            let buttonStack = UIStackView(arrangedSubviews: [bagButton, heartButton, profileButton])
            buttonStack.spacing = 28
            buttonStack.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(buttonStack)
            
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -45).isActive = true
            buttonStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
        }
}

