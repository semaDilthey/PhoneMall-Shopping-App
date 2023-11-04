

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifire = "CustomCellSection1"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
        view.backgroundColor = .white
    }
    
    override func prepareForReuse() {
       view.backgroundColor = .white
        
    }
         
    lazy var view : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    func set(viewModel: CategoryCellViewModel, indexPath: IndexPath) {
        self.label.text = viewModel.title
        self.image.image = viewModel.picture
    }
    
    
    // Change cell color in HomeVC extensions
    func changeCellColor(isSelected:Bool, cell: CategoryCell) {
        if isSelected == true {
            cell.view.backgroundColor = .customOrange
            cell.label.textColor = .customOrange
            cell.label.font = UIFont.markProFont(size: 12, weight: .heavy)
        } else if isSelected == false {
            cell.view.backgroundColor = .white
            cell.label.textColor = .black
            cell.label.font = UIFont.markProFont(size: 12, weight: .plain)
            }
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
