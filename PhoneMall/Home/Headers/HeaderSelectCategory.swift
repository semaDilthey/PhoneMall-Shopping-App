//
//  HeaderSelectCategory.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 24.06.2023.
//

import Foundation
import UIKit

class HeaderSelectCategory: UICollectionReusableView {
    
    static let headerID = "HeaderSelectCategory"
    
    var locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Zihuatanejo" + "," + " " + "Gro"
        label.textColor = .black
        label.font = UIFont.markProFont(size: 14, weight: .plain)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "location")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var chooseLocationButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setImage(UIImage(named: "tag"), for: .normal)
        return button
    }()
    
    lazy var filterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setImage(UIImage(named: "filter"), for: .normal)
        return button
    }()
    
    private let labelBestSeller : UILabel = {
        let label = UILabel()
        label.text = "Select category"
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
        button.setTitle("view all", for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        
        addSubview(locationLabel)
        addSubview(locationImage)
        addSubview(chooseLocationButton)
        addSubview(filterButton)
        addSubview(seeMoreButton)
        addSubview(labelBestSeller)
      
        locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: labelBestSeller.topAnchor, constant: -12).isActive = true
        
        locationImage.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 5).isActive = true
        locationImage.bottomAnchor.constraint(equalTo: labelBestSeller.topAnchor, constant: 1).isActive = true
        locationImage.frame.size = CGSize(width: 12, height: 14)

        
        chooseLocationButton.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 8).isActive = true
        chooseLocationButton.bottomAnchor.constraint(equalTo: labelBestSeller.topAnchor, constant: -1).isActive = true
        chooseLocationButton.frame.size = CGSize(width: 12, height: 7)
        
        filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        filterButton.topAnchor.constraint(equalTo: topAnchor, constant: -21).isActive = true
        filterButton.frame.size = CGSize(width: 11, height: 13)


        
        labelBestSeller.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        labelBestSeller.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
