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
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let superView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customDarkBlue
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explorer"
        label.font = .markProFont(size: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    
    private let circle : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    
    private func setupUI() {
        self.addSubview(label)
        
//        superView.fillSuperview()
//        
//        superView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}

