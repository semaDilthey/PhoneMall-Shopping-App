

import UIKit

class BestSellerCell: UICollectionViewCell {
    
    static let identifire = "CustomCellSection3"
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
// MARK: - Properties
   // ViewModel для ячейки
   var viewModel: BestSellerModelProtocol? {
       didSet {
           configureCell()
           updateFavoritesUI()
       }
   }
   
    //MARK: - UI Objects
   // Изображение товара
   lazy var image: WebImageView = {
       let image = WebImageView()
       image.image = UIImage(named: "homeStoreSamsungNote")
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
   }()
   
   // Кнопка "Добавить в избранное"
   lazy var isFavoritesButton: UIButton = {
       let button = UIButton()
       button.backgroundColor = .white
       button.setImage(UIImage(named: "heartEmpty"), for: .normal)
       button.clipsToBounds = true
       button.layer.cornerRadius = 12
       button.translatesAutoresizingMaskIntoConstraints = false
       button.layer.shadowOffset = CGSize(width: 5, height: 5)
       button.layer.shadowRadius = 5
       button.layer.shadowColor = UIColor.gray.cgColor
       button.layer.shadowOpacity = 1.0
       button.isSelected = false
       button.addTarget(self, action: #selector(didTappedFavorites), for: .touchUpInside)
       return button
   }()
   
   // Цена товара
   let priceLabel: UILabel = {
       let label = UILabel()
       label.text = "1500$"
       label.textColor = .black
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.markProFont(size: 16, weight: .heavy)
       return label
   }()
   
   // Цена со скидкой
   let discountPriceLabel: UILabel = {
       let label = UILabel()
       let attributeString = NSMutableAttributedString(string: "$1111")
       attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
       label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
       label.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
       label.attributedText = attributeString
       label.font = UIFont.markProFont(size: 10, weight: .plain)
       label.textColor = .gray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
   
   // Название товара
   let nameLabel: UILabel = {
       let label = UILabel()
       label.text = "Phone name lalalalal"
       label.font = UIFont.markProFont(size: 10, weight: .plain)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
   
   
   // MARK: - UI Configuration
   
   private func configureCell() {
       // Настройка данных ячейки при установке ViewModel
       priceLabel.text = viewModel?.fullPrice
       discountPriceLabel.text = viewModel?.discountPrice
       nameLabel.text = viewModel?.title
       image.set(imageURL: viewModel?.pictureUrlString)
   }
   
   // Обновление внешнего вида кнопки "Добавить в избранное"
   func updateFavoritesUI() {
       isFavoritesButton.isSelected = viewModel?.isFavorites ?? false
       let heartImage = isFavoritesButton.isSelected ? "heartFilled" : "heartEmpty"
       isFavoritesButton.setImage(UIImage(named: heartImage), for: .normal)
   }
   
   // MARK: - Button Setup
   // Обработка нажатия на кнопку "Добавить в избранное"
   @objc func didTappedFavorites() {
       viewModel?.isFavorites = !isFavoritesButton.isSelected
       updateFavoritesUI()
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
