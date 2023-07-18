
import UIKit


class MyCartCell: UITableViewCell {
    
    static let identifire = "MyCartCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        stepper.counter = "1"
    }

    
    var viewModel : MyCartCellModelProtocol? {
        didSet {
            phoneNameLabel.text = viewModel?.title
            phonePicture.set(imageURL: viewModel?.picture)
            
            if let price = viewModel?.price {
                        self.phonePriceLabel.text = ("$"+String(price)+".00")
            } else {
                phonePriceLabel.text = "No data"
            }
        }
    }
    
    func updatePrice(by value: Int) {
        if let price = viewModel?.price {
            phonePriceLabel.text = "$"+String(value * price)+".00"
        } else {
            phonePriceLabel.text = "No data"

        }
    }
    

    let phonePicture : WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return image
    }()
    
    let phoneNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.markProFont(size: 21, weight: .medium)
        return label
    }()
    
    let phonePriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 18, weight: .medium)
        label.textColor = .customOrange
        return label
    }()
    
    lazy var trashButton : UIButton = {
        let butt = UIButton()
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setImage(UIImage(systemName: "trash"), for: .normal)
        butt.tintColor = UIColor(red: 40/255, green: 40/255, blue: 67/255, alpha: 1)
        return butt
    }()

    lazy var stepper : CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.layer.cornerRadius = 6
        return stepper
    }()
    
    
    func setupUI() {
        contentView.backgroundColor = .customDarkBlue
        
        contentView.addSubview(phonePicture)
                phonePicture.anchor(top: contentView.topAnchor,
                                        leading: contentView.leadingAnchor,
                                        bottom: contentView.bottomAnchor,
                                        trailing: nil,
                                        padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 0))
                phonePicture.widthAnchor.constraint(equalTo: phonePicture.heightAnchor).isActive = true
                
        contentView.addSubview(phoneNameLabel)
                phoneNameLabel.anchor(top: contentView.topAnchor,
                                        leading: phonePicture.trailingAnchor,
                                        bottom: contentView.centerYAnchor,
                                        trailing: nil,
                                        padding: UIEdgeInsets(top: 2, left: 16, bottom: 0, right: 0))
                phoneNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
                
        contentView.addSubview(phonePriceLabel)
                phonePriceLabel.leadingAnchor.constraint(equalTo: phoneNameLabel.leadingAnchor).isActive = true
                phonePriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
               
                
        contentView.addSubview(trashButton)
                trashButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
                
        contentView.addSubview(stepper)
                stepper.anchor(top: contentView.topAnchor,
                                 leading: nil,
                                 bottom: contentView.bottomAnchor,
                                 trailing: trashButton.leadingAnchor,
                                 padding: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 24),
                                 size: CGSize(width: 26, height: 0))
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
