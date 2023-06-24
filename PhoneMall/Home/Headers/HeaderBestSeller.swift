//
//  HeaderBestSeller.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 24.06.2023.
//

import Foundation
import UIKit

class HeaderBestSeller : UICollectionReusableView {
    
    static let headerID = "HeaderBestSeller"
    
    private let labelBestSeller : UILabel = {
        let label = UILabel()
        label.text = "Best seller"
        label.textColor = .black
        label.font = UIFont.markProFont(size: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seeMoreButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.markProFont(size: 15, weight: .plain)
        button.setTitleColor(UIColor.customOrange, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("see more", for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(seeMoreButton)
        addSubview(labelBestSeller)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
      
        labelBestSeller.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        labelBestSeller.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
