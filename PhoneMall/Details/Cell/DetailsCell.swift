
import UIKit

class DetailsCell: UICollectionViewCell {
    
    static let identife = "identifire"
    
    var viewModel : DetailsCellModelProtocol? {
        didSet {
            configureCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .clear
        self.addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView : WebImageView = {
        let image = WebImageView()
        image.image = UIImage(named: "homeStoreSamsungNote")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = bounds
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        return image
    }()
    
    private func configureCell() {
        imageView.set(imageURL: viewModel?.images?[0])
    }
}


private extension DetailsCell {
    
    func setupUI() {
        contentView.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
