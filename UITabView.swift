//
//  UITabView.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 03.11.2023.
//

import UIKit
import SwiftUI

class UITabView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
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
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
  
    
    
    private func setupUI() {
        addSubview(superView)
        
        superView.fillSuperview()
        
        superView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        
    }
}

