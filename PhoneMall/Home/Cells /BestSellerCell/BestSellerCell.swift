

import UIKit

class BestSellerCell: UICollectionViewCell {
    
    static let identifire = "CustomCellSection3"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
       // isFavoritesTapped = UserDefaults.standard.bool(forKey: "isFavoritesTapped")
        
//        isFavorites = UserDefaults.standard.bool(forKey: "isFavoritesTapped_\(self.tag)")
//        if isFavorites {
//                isFavoritesButton.setImage(UIImage(named: "heartFilled"), for: .normal)
//            } else {
//                isFavoritesButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
//            }
    }
    
    var cellViewModel : BestSellerCellViewModelProtocol? {
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
        butt.layer.shadowColor = UIColor.black.cgColor
        butt.layer.shadowOpacity = 0.5
        butt.layer.shadowOffset = CGSize.zero
        butt.layer.shadowRadius = 12
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
    
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.text = "1500$"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 16, weight: .heavy)
        return label
    }()
    
    lazy var discountPriceLabel : UILabel = {
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
  
    lazy var nameLabel : UILabel = {
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
    
    func setupUI() {
        
        contentView.addSubview(image)
        contentView.addSubview(isFavoritesButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountPriceLabel)
        contentView.addSubview(nameLabel)
        
        if image.image == UIImage(named: "loading") {
            image.frame.size = CGSize(width: contentView.frame.width / 2, height: 88)
        } else {
            image.frame.size = CGSize(width: contentView.frame.width, height: 177)
        }
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 160),
            
            
            isFavoritesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            isFavoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isFavoritesButton.widthAnchor.constraint(equalToConstant: 24),
            isFavoritesButton.heightAnchor.constraint(equalToConstant: 24),
            
            priceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            priceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            discountPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            discountPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: -4),
            
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21)

        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
