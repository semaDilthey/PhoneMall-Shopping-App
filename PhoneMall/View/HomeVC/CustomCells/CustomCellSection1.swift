

import UIKit

class CustomCellSection1: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutSubviews()
        
    }
    
    
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
        label.font = UIFont(name: "DSLCLU+MarkPro-Medium", size: 13)
        label.text = "Phones"
        label.textColor = UIColor(named: "customDarkBlue")
        //label.textAlignment = .center
        return label
    }()
    
    lazy var image : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "house")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
//    func makeStackView() -> UIStackView {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.distribution = .fill
//        stack.alignment = .fill
//        stack.spacing = 8.0
//        return stack
//    }
    
    
    //MARK: - Расстановка лэйаута для наших сабВьюх
    override func layoutSubviews() {
        super.layoutSubviews()


        
        contentView.addSubview(view)
        contentView.addSubview(label)
        contentView.addSubview(image)
        
        
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}