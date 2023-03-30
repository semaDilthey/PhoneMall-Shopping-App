
import UIKit

class ProductDetailsCustomCell: UICollectionViewCell {
    
    static let identife = "identifire"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .red
    }
    
    
    lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "homeStoreSamsungNote")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = bounds
        image.clipsToBounds = true
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
