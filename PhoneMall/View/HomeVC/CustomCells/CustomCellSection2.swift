

import UIKit

class CustomCellSection2: UICollectionViewCell {
    
    static let identifire = "CustomCellSection2"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainImage)
        contentView.addSubview(isNewImage)
        contentView.addSubview(phoneTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(button)

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
    
    lazy var isNewImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "house")
        image.backgroundColor = .clear
        return image
    }()
    
    lazy var phoneTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IPHONE"
        label.textColor = .red
        return label
    }()
    
    lazy var subtitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some words bout phone"
        label.textColor = .white
        return label
    }()
        
    private let button : UIButton = {
        let butt = UIButton()
        butt.setTitle("Buy now!", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.backgroundColor = .white
        butt.translatesAutoresizingMaskIntoConstraints = false
        return butt
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstaints()
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            isNewImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            isNewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            isNewImage.heightAnchor.constraint(equalToConstant: 40),
            isNewImage.widthAnchor.constraint(equalToConstant: 40),
            
            phoneTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            phoneTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            
            subtitleLabel.topAnchor.constraint(equalTo: phoneTitleLabel.bottomAnchor, constant: 7),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            button.widthAnchor.constraint(equalToConstant: contentView.frame.width/4),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
    }
}
