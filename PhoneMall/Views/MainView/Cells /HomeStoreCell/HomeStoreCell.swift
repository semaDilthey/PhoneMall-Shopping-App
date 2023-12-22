

import UIKit
import SwiftUI

class HomeStoreCell: UICollectionViewCell {
    
    static let identifire = "CustomCellSection2"
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 15
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    var viewModel : HomeStoreCellModelProtocol? {
        didSet {
            configureCell()
        }
    }
    
    // Изображение товара, подгружается с интернета
    private let mainImage: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // Метка для нового товара
    private let newLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .customOrange
        label.widthAnchor.constraint(equalToConstant: 36).isActive = true
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
        label.clipsToBounds = true
        label.layer.cornerRadius = 18
        label.textColor = .white
        label.text = "New"
        label.font = UIFont.markProFont(size: 10, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    // Название товара
    private let phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.markProFont(size: 25, weight: .heavy)
        return label
    }()
    
    // Подзаголовок товара
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.markProFont(size: 11, weight: .plain)
        return label
    }()
    
    // Метка для кнопки "Купить"
    private let buyNowLabel: UILabel = {
        let label = UILabel()
        label.text = "Buy now!"
        label.textColor = .black
        label.font = UIFont.markProFont(size: 13, weight: .heavy)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - UI Configuration
    private func configureCell() {
        mainImage.set(imageURL: viewModel?.pictureUrlString)
        phoneTitleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.subtitle
    }
    
}


//MARK: - SetupUI
private extension HomeStoreCell {
    
    func setupUI() {
        
        contentView.addSubview(mainImage)
        contentView.addSubview(newLabel)
        contentView.addSubview(phoneTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(buyNowLabel)
        
        
        NSLayoutConstraint.activate([
            mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            newLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23),
            newLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            phoneTitleLabel.topAnchor.constraint(equalTo: newLabel.bottomAnchor, constant: 18),
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



//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        MainViewController().showPreview()
//    }
//}
