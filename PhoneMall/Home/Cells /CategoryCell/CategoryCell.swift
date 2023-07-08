

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }
    
    var viewModel = CategoryCellViewModel()
    
    static let identifire = "CustomCellSection1"
    
    lazy var view : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = contentView.frame.width/2
        view.backgroundColor = .white
        return view
    }()
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 12, weight: .plain)
        label.textColor = UIColor.customDarkBlue
        label.textAlignment = .center
        return label
    }()
    
    lazy var image : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func configure(viewModel: CategoryCellViewModel, indexPath: IndexPath) {
            
        self.label.text = viewModel.categories[indexPath.row].title
        self.image.image = viewModel.categories[indexPath.row].image
    }
    
    //MARK: - Расстановка лэйаута для наших сабВьюх
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(view)
        contentView.addSubview(label)
        contentView.addSubview(image)
        
        view.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 3).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
