

import UIKit

class CustomCellSection3: UICollectionViewCell {
    
    static let identifire = "CustomCellSection3"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(isFavoritesButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountPriceLabel)
        contentView.addSubview(nameLabel)


    }
    
    lazy var image : UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "pp1")
        image.image = UIImage(systemName: "house")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // значения для кнопки надо сохранять в юзерДефолтс
    lazy var isFavoritesButton : UIButton = {
        let butt = UIButton()
        butt.backgroundColor = UIColor(named: "snowyWhite")
        butt.setImage(UIImage(systemName: "heart"), for: .normal)
        butt.clipsToBounds = true
        butt.layer.cornerRadius = 16
        butt.translatesAutoresizingMaskIntoConstraints = false
        return butt
    }()
    
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.text = "1500$"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DSLCLU+MarkPro-Medium", size: 16)
        return label
    }()
    
    lazy var discountPriceLabel : UILabel = {
        let label = UILabel()
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$1111")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        label.attributedText = attributeString
        label.font = UIFont(name: "DSLCLU+MarkPro-Thin", size: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Phone name lalalalal"
        label.font = UIFont(name: "DSLCLU+MarkPro", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstaints()
    }
    
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            isFavoritesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            isFavoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isFavoritesButton.widthAnchor.constraint(equalToConstant: 30),
            isFavoritesButton.heightAnchor.constraint(equalToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            priceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            discountPriceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -5),
            discountPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 3),
            discountPriceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
            discountPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)



        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
