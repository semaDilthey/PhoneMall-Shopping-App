

import Foundation
import UIKit

protocol ReusableViewDelegate: AnyObject { //send signal to MainViewController()
    func didTapFilterButton()
}

class HeaderSelectCategory: UICollectionReusableView {
    
    // MARK: - Constants
    static let headerID = "HeaderSelectCategory"
    
    // MARK: - Properties
    weak var delegate : ReusableViewDelegate?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bringSubviewToFront(filterButton)
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
    private let locationLabel : UILabel = {
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
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.addTarget(self, action: #selector(filtersButtonTapped), for: .touchUpInside)
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
    
     lazy var seeMoreButton : UIButton = {
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
    
    // MARK: - Methods

    @objc func filtersButtonTapped() {
        print("aaa")
        delegate?.didTapFilterButton()
     }
}

//MARK: - SetupUI
extension HeaderSelectCategory {
    
    func setupUI() {
        addSubview(locationLabel)
        locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        addSubview(locationImage)
        locationImage.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 5).isActive = true
        locationImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        locationImage.frame.size = CGSize(width: 12, height: 14)

        addSubview(chooseLocationButton)
        chooseLocationButton.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 8).isActive = true
        chooseLocationButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        chooseLocationButton.frame.size = CGSize(width: 12, height: 7)
        
        addSubview(filterButton)
        filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        filterButton.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        filterButton.frame.size = CGSize(width: 11, height: 13)

        addSubview(labelBestSeller)
        labelBestSeller.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        labelBestSeller.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        addSubview(seeMoreButton)
        seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        seeMoreButton.centerYAnchor.constraint(equalTo: labelBestSeller.centerYAnchor).isActive = true
    }
}
