

import UIKit

class BestSellerCell: UICollectionViewCell {
    
    static let identifire = "CustomCellSection3"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = .white
        
        setupButton()
    }
    
    var cellViewModel : BestSellerModelProtocol? {
        didSet {
            priceLabel.text = cellViewModel?.fullPrice
            discountPriceLabel.text = cellViewModel?.discountPrice
            nameLabel.text = cellViewModel?.title
            image.set(imageURL: cellViewModel?.pictureUrlString)
            
            updateFavoritesUI()
        }
    }
    
    func updateFavoritesUI() {
        if let cellViewModel = cellViewModel {
            isFavoritesButton.isSelected = cellViewModel.isFavorites ?? false
        }
    }
    
    lazy var image : WebImageView = {
        let image = WebImageView()
        image.image = UIImage(named: "homeStoreSamsungNote")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    // значения для кнопки надо сохранять в юзерДефолтс
    lazy var isFavoritesButton : UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .white
        butt.setImage(UIImage(named: "heartEmpty"), for: .normal)
        butt.clipsToBounds = true
        butt.layer.cornerRadius = 12
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt
        butt.layer.shadowOffset = CGSizeMake(5, 5)
            // set the radius
        butt.layer.shadowRadius = 5

            // change the color of the shadow (has to be CGColor)
        butt.layer.shadowColor = UIColor.gray.cgColor
            
            // display the shadow
        butt.layer.shadowOpacity = 1.0
        var status : Bool = false
        return butt
    }()
    
    func setupButton() {
        isFavoritesButton.addTarget(self, action: #selector(didTappedFavorites), for: .touchUpInside)
    }
    
    @objc func didTappedFavorites() {
        cellViewModel?.isFavorites = !isFavoritesButton.isSelected
        isFavoritesButton.isSelected = cellViewModel?.isFavorites ?? false
        
        if isFavoritesButton.isSelected {
            isFavoritesButton.setImage(UIImage(named: "heartFilled"), for: .normal)
        } else {
            isFavoritesButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
        }
    }
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "1500$"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 16, weight: .heavy)
        return label
    }()
    
    let discountPriceLabel : UILabel = {
        let label = UILabel()
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$1111")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        label.attributedText = attributeString
        label.font = UIFont.markProFont(size: 10, weight: .plain)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Phone name lalalalal"
        label.font = UIFont.markProFont(size: 10, weight: .plain)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - SetupUI
extension BestSellerCell {
    
    func setupUI() {
        
        contentView.addSubview(image)
        contentView.addSubview(isFavoritesButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountPriceLabel)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            image.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 160),
            
            isFavoritesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            isFavoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isFavoritesButton.widthAnchor.constraint(equalToConstant: 24),
            isFavoritesButton.heightAnchor.constraint(equalToConstant: 24),
            
            priceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            priceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            discountPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            discountPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: -4),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)

        ])
        
    }
}
