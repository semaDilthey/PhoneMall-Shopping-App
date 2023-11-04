
import UIKit

class DetailsCell: UICollectionViewCell {
    
    static let identife = "identifire"
    
    var viewModel : DetailsCellModelProtocol? {
        didSet {
            imageView.set(imageURL: viewModel?.images?[0])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .clear
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
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true


    }
}
