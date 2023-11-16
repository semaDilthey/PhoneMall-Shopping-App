//
//  HeaderBestSeller.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 24.06.2023.
//

import Foundation
import UIKit

class HeaderBestSeller: UICollectionReusableView {
    
    // MARK: - Constants
    
    static let headerID = "HeaderBestSeller"
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    // MARK: - UI Elements
    private let labelBestSeller: UILabel = {
        let label = UILabel()
        label.text = "Best seller"
        label.textColor = .black
        label.font = UIFont.markProFont(size: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var seeMoreButton: UIButton = {
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
}

// MARK: - SetupUI
private extension HeaderBestSeller {
    
    func setupUI() {
        addSubview(labelBestSeller)
        NSLayoutConstraint.activate([
            labelBestSeller.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            labelBestSeller.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        addSubview(seeMoreButton)
        NSLayoutConstraint.activate([
            seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
