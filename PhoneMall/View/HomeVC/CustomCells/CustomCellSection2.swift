

import UIKit
import SwiftUI

class CustomCellSection2: UICollectionViewCell {
    
    static let identifire = "CustomCellSection2"

    override init(frame: CGRect) {
        super.init(frame: frame)
       

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mainImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pp1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var isNewLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .customOrange
        label.widthAnchor.constraint(equalToConstant: 36).isActive = true
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
        label.clipsToBounds = true
        label.layer.cornerRadius = 18
        label.text = "New"
        label.textColor = .white
        label.font = UIFont.markProFont(size: 10, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    lazy var phoneTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IPHONE"
        label.textColor = .white
        label.font = UIFont.markProFont(size: 25, weight: .heavy)
        return label
    }()
    
    lazy var subtitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some words bout phone"
        label.textColor = .white
        label.font = UIFont.markProFont(size: 11, weight: .plain)
        return label
    }()
        
    private let buyNowLabel : UILabel = {
        let butt = UILabel()
        butt.text = "Buy now!"
        butt.textColor = .black
        butt.font = UIFont.markProFont(size: 13, weight: .heavy)
        butt.backgroundColor = .white
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.clipsToBounds = true
        butt.layer.cornerRadius = 4
        butt.textAlignment = .center
        return butt
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        
        contentView.addSubview(mainImage)
        contentView.addSubview(isNewLabel)
        contentView.addSubview(phoneTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(buyNowLabel)
        
        
        NSLayoutConstraint.activate([
            mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            isNewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23),
            isNewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            phoneTitleLabel.topAnchor.constraint(equalTo: isNewLabel.bottomAnchor, constant: 18),
            phoneTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            subtitleLabel.bottomAnchor.constraint(equalTo: buyNowLabel.topAnchor, constant: -20),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            buyNowLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            buyNowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            buyNowLabel.widthAnchor.constraint(equalToConstant: 98),
            buyNowLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
        
    }
}

struct ViewControllerProvider : PreviewProvider {
    static var previews: some View {
        HomeVC().showPreview()
    }
}
