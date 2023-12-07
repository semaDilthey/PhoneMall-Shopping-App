

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifire = "CustomCellSection1"
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Lifecycle
    
    override func prepareForReuse() {
        view.backgroundColor = .white
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? configureSelectedState() : configureUnselectedState()
        }
    }
    
    // MARK: - UI Elements
    
    lazy var view : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = contentView.frame.width/2
        return view
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 12, weight: .plain)
        label.textColor = UIColor.customDarkBlue
        label.textAlignment = .center
        return label
    }()
    
    let image : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image?.withRenderingMode(.alwaysTemplate)
        return image
    }()
    
    // MARK: - Configuration
    
    func configureSelection() {
        if isSelected {
            view.backgroundColor = .customOrange
            label.textColor = .customOrange
            label.font = UIFont.markProFont(size: 12, weight: .heavy)
        } else {
            view.backgroundColor = .white
            label.textColor = .black
            label.font = UIFont.markProFont(size: 12, weight: .plain)
        }
    }
    
    func configureSelectedState() {
        view.backgroundColor = .customOrange
        label.textColor = .customOrange
        label.font = UIFont.markProFont(size: 12, weight: .heavy)
    }
    
    func configureUnselectedState() {
        view.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.markProFont(size: 12, weight: .plain)
    }
         
    // MARK: - Public Methods
    func set(viewModel: CategoryCellViewModel, indexPath: IndexPath) {
        self.label.text = viewModel.title
        self.image.image = viewModel.picture
    }
    
    
    
    //MARK: - Private Methods
    override func layoutSubviews() {
        super.layoutSubviews()
       
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(image)
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 3).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
}
