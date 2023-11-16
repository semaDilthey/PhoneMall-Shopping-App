//
//  HeaderHotSaler.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 24.06.2023.
//

import Foundation
import UIKit

class HeaderHotSales: UICollectionReusableView, UISearchBarDelegate {
  
    // MARK: - Constants

    static let headerID = "HeaderHotSales"
    private let searchBar = SearchBar()
   
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: .zero, y: .zero, width: frame.width, height: 100))
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
    lazy var qrButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .customOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .center
        button.setImage(UIImage(named: "qr"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let labelHotSales : UILabel = {
        let label = UILabel()
        label.text = "Hot sales"
        label.textColor = .black
        label.font = UIFont.markProFont(size: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreButton : UIButton = {
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


//MARK: - SetupUI
extension HeaderHotSales {
    
    func setupUI() {
        addSubview(labelHotSales)
        labelHotSales.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        labelHotSales.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        addSubview(searchBar)
        searchBar.bottomAnchor.constraint(equalTo: labelHotSales.topAnchor, constant: -24).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -82).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        addSubview(seeMoreButton)
        seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        seeMoreButton.centerYAnchor.constraint(equalTo: labelHotSales.centerYAnchor).isActive = true
        
        addSubview(qrButton)
        qrButton.bottomAnchor.constraint(equalTo: seeMoreButton.topAnchor, constant: -38).isActive = true
        qrButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 11).isActive = true
        qrButton.frame.size = CGSize(width: 36, height: 36)
        
    }
    
}
