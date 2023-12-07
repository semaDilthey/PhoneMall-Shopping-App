

import Foundation
import UIKit
import Cosmos

protocol CardViewResponderProtocol: AnyObject {
    func favoritesButtonPressed()
    func addToCartButtonPressed()
    func changedCapacity(sender: UITapGestureRecognizer)
    func changedColor(sender: UITapGestureRecognizer)
}

class CardView : UIView, UIGestureRecognizerDelegate {
    
    weak var delegate : CardViewResponderProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Лейбл с названием телефона
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .customDarkBlue
        label.font = UIFont.markProFont(size: 22, weight: .medium)
        label.textAlignment = .center
        label.text = "Galaxy Note 20 Ultra"
        label.layer.shouldRasterize = false
        return label
    }()
    
    // Cоздаем 5 картинок звезды
    lazy var cosmosView : CosmosView = {
        var view = CosmosView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Rate phone"
        view.rating = 0
        view.settings.textColor = .customDarkBlue!
        view.settings.fillMode = .half
        view.settings.textFont = .markProFont(size: 14, weight: .medium)!
        return view
    }()
    
    //кнопка избранное
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "heartEmpty")?.imageWithColor(color: .white)
        button.setImage(image, for: .normal)
        button.imageView?.sizeToFit()
        button.layer.backgroundColor = UIColor.customDarkBlue?.cgColor
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(didTappedFav), for: .touchUpInside)
        return button
    }()
    
    
    
    //кнопки Shop, Details, Features в SegmentedControl
    private enum Constants {
            static let segmentedControlHeight: CGFloat = 40
            static let underlineViewColor: UIColor = .customOrange
            static let underlineViewHeight: CGFloat = 3
            static let underlineViewRadius: CGFloat = underlineViewHeight/2
        }

        // Container view of the segmented control
    private lazy var segmentedControlContainerView: UIView = {
            let containerView = UIView()
            containerView.backgroundColor = .clear
            containerView.translatesAutoresizingMaskIntoConstraints = false
            return containerView
        }()

        // Customised segmented control
    private lazy var segmentedControl: UISegmentedControl = {
            let segmentedControl = UISegmentedControl()

            // Remove background and divider colors
            segmentedControl.backgroundColor = .clear
            segmentedControl.tintColor = .clear

            // Append segments
            segmentedControl.insertSegment(withTitle: "Shop", at: 0, animated: true)
            segmentedControl.insertSegment(withTitle: "Details", at: 1, animated: true)
            segmentedControl.insertSegment(withTitle: "Features", at: 2, animated: true)

            // Select first segment by default
            segmentedControl.selectedSegmentIndex = 0

            // Change text color and the font of the NOT selected (normal) segment
            segmentedControl.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.markProFont(size: 20, weight: .plain) as Any], for: .normal)

            // Change text color and the font of the selected segment
            segmentedControl.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue as Any,
                NSAttributedString.Key.font: UIFont.markProFont(size: 20, weight: .heavy) as Any], for: .selected)

            // Set up event handler to get notified when the selected segment changes
            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

            // Return false because we will set the constraints with Auto Layout
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            // удаляем фон и полоски
            segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
            segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            // меняем положение 0 и 2 сегмента в осях Х
            segmentedControl.setContentPositionAdjustment(UIOffset(horizontal: 5, vertical: 0), forSegmentType: .right, barMetrics: .default)
            
            return segmentedControl
        }()

        // The underline view below the segmented control
    private lazy var bottomUnderlineView: UIView = {
            let underlineView = UIView()
            underlineView.backgroundColor = Constants.underlineViewColor
            underlineView.layer.cornerRadius = Constants.underlineViewRadius
            underlineView.translatesAutoresizingMaskIntoConstraints = false
            return underlineView
        }()

    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
            return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
        }()
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
           changeSegmentedControlLinePosition()
       }

       // Change position of the underline
    private func changeSegmentedControlLinePosition() {
           let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
           let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
           let leadingDistance = segmentWidth * segmentIndex
           UIView.animate(withDuration: 0.3, animations: { [weak self] in
               self?.leadingDistanceConstraint.constant = leadingDistance
//               self?.collectionView.layoutIfNeeded()
           })
       }


    // Label Select color and Capacity
    private let colorCapacityLabel: UILabel = {
        let label = UILabel()
        label.text = "Select color and capacity"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 16, weight: .medium)
        return label
    }()
    
    // создаем лейблы 2х цветов
    lazy var circleLabelBrown: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .brown
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.widthAnchor.constraint(equalToConstant: 39).isActive = true
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        label.isUserInteractionEnabled = true
        let tapGesture12 = UITapGestureRecognizer(target: self, action: #selector(changedColor))
        tapGesture12.delegate = self
        label.addGestureRecognizer(tapGesture12)
        return label
    }()
    
    lazy var circleLabelBlack: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.widthAnchor.constraint(equalToConstant: 39).isActive = true
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        label.isUserInteractionEnabled = true
        let tapGesture12 = UITapGestureRecognizer(target: self, action: #selector(changedColor))
        tapGesture12.delegate = self
        label.addGestureRecognizer(tapGesture12)
        return label
    }()
    
    // создадим 2 по сути одинаковые кнопки, но одна будет нажата, а другая нет
    lazy var gb128Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor.customOrange.cgColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.markProFont(size: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.textAlignment = .center
        label.text = "128 GB"
        label.widthAnchor.constraint(equalToConstant: 71).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(changedCapacity))
        tapGesture1.delegate = self
        label.addGestureRecognizer(tapGesture1)
        return label
    }()
    
    lazy var gb256Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.markProFont(size: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "256 GB"
        label.widthAnchor.constraint(equalToConstant: 71).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(changedCapacity))
        tapGesture2.delegate = self
        label.addGestureRecognizer(tapGesture2)
        return label
    }()
    
    
    //добавляет Label Add to Cart в кнопке
    var addToCartLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.font = UIFont.markProFont(size: 20, weight: .medium)
        label.text = "Add to Cart"
        label.textColor = .white
        return label
    }()
    // добавляет цену в кнопке
    var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.font = UIFont.markProFont(size: 20, weight: .medium)
        label.text = "$ 1500"
        label.textColor = .white
        label.layer.shouldRasterize = false
        return label
    }()
    // добавляет кнопку
    lazy var addToCartButton : UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .customOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.shouldRasterize = false
        button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        button.startAnimatingPressActions()
        return button
    }()
    
    static func createImagePhoneOptions (name: String, width: Int, height: Int) -> UIImageView { // создает картинку
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: name)
        image.frame = CGRect(x: 0, y: 0, width: width, height: height)
        image.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }
    
    static func createLabelPhoneOptions (text : String) -> UILabel { // создает лейбл
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.text = text
        label.adjustsFontSizeToFitWidth = false
        label.font = UIFont.markProFont(size: 10, weight: .plain)
        label.textColor = UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)
        label.textAlignment = .justified
        return label
    }

    // объекты картинок
    static let processorImage = createImagePhoneOptions(name: "processor", width: 28, height: 28)
    static let operativkaImage = createImagePhoneOptions(name: "operativka", width: 21, height: 28)
    static let memoryCardImage = createImagePhoneOptions(name: "memoryCard", width: 19, height: 22)
    static let cameraOptionsImage = createImagePhoneOptions(name: "cameraOptions", width: 28, height: 22)
    // объекты лейблов
    static let memoryCardLabel = createLabelPhoneOptions(text: "256 GB")
    static let operativkaLabel = createLabelPhoneOptions(text: "8 GB")
    static let cameraOptionsLabel = createLabelPhoneOptions(text: "108 + 12 mp")
    static let processorLabel = createLabelPhoneOptions(text: "Exynos 990")
    
    // функция, которая засунет лейбл и фотки в один стак
    static func makeVerticalStack(image : UIImageView, label: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 4
        stack.backgroundColor = .clear
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(label)
        return stack
    }
    // 4 стака для лейбла + картинка
    static let processorStack = makeVerticalStack(image: processorImage, label: processorLabel)
    static let cameraStack = makeVerticalStack(image: cameraOptionsImage, label: cameraOptionsLabel)
    static let operativkaStack = makeVerticalStack(image: operativkaImage, label: operativkaLabel)
    static let memoryStack = makeVerticalStack(image: memoryCardImage, label: memoryCardLabel)
    
    // суем 4 стака в один большой стак
    
    // сперва напишем для этого функцию
    static func makeHorizontalStackOfStacks(stack1 : UIStackView, stack2 : UIStackView, stack3 : UIStackView, stack4 : UIStackView) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 15
        stack.backgroundColor = .clear
        stack.addArrangedSubview(stack1)
        stack.addArrangedSubview(stack2)
        stack.addArrangedSubview(stack3)
        stack.addArrangedSubview(stack4)
        stack.backgroundColor = .clear
        return stack
    }
    
    // ну а теперь можно и засунуть
    let optionsStack = makeHorizontalStackOfStacks(stack1: processorStack, stack2: cameraStack, stack3: operativkaStack, stack4: memoryStack)
    
    // делаем функцию для стака звезд
    private func giggabytesStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 3
        stackView.backgroundColor = .clear
        return stackView
    }
    
    private func circlesStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 5
        stack.backgroundColor = .clear
        return stack
    }
    
 
    //MARK: - Button Methods
      
    @objc func didTappedFav() {
        delegate?.favoritesButtonPressed()
    }
    
    // это надо потом во вью модель
    @objc func changedCapacity(sender: UITapGestureRecognizer) {
        delegate?.changedCapacity(sender: sender)
    }
//    
    @objc func changedColor(sender: UITapGestureRecognizer) {
        delegate?.changedColor(sender: sender)
    }
//    
    @objc func addToCartButtonTapped() {
        delegate?.addToCartButtonPressed()
    }
}


//MARK: - SetupUI

private extension CardView {
    
    func setupUI() {
        addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        addSubview(cosmosView)
        cosmosView.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 6).isActive = true
        cosmosView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        addSubview(favButton)
        favButton.topAnchor.constraint(equalTo: topAnchor, constant: 28).isActive = true
        favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
       
        addSubview(segmentedControlContainerView)
        NSLayoutConstraint.activate([
                    segmentedControlContainerView.topAnchor.constraint(equalTo: cosmosView.bottomAnchor, constant: 25),
                    segmentedControlContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                    segmentedControlContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                    segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
                    ])
        
        addSubview(optionsStack)
        optionsStack.topAnchor.constraint(equalTo: segmentedControlContainerView.bottomAnchor, constant: 25).isActive = true
        optionsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        optionsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        // Constrain the segmented control to the container view
        segmentedControlContainerView.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
                    segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
                    segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
                    segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
                    segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
                    ])
        
            // Constrain the underline view relative to the segmented control
        segmentedControlContainerView.addSubview(bottomUnderlineView)
        NSLayoutConstraint.activate([
                    bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
                    bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
                    leadingDistanceConstraint,
                    bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
                    ])
        

          addSubview(colorCapacityLabel)
          colorCapacityLabel.topAnchor.constraint(equalTo: optionsStack.bottomAnchor, constant: 35).isActive = true
          colorCapacityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true

          //стак для кругляшек
          let circlesStack = circlesStack()
          circlesStack.addArrangedSubview(circleLabelBrown)
          circlesStack.addArrangedSubview(circleLabelBlack)
          circlesStack.spacing = 15

          addSubview(circlesStack)
          circlesStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
          circlesStack.topAnchor.constraint(equalTo: colorCapacityLabel.bottomAnchor, constant: 20).isActive = true

          //стак для гигов
          let gbStack = giggabytesStack()
          gbStack.addArrangedSubview(gb128Label)
          gbStack.spacing = 12
          gbStack.addArrangedSubview(gb256Label)

          addSubview(gbStack)
          gbStack.topAnchor.constraint(equalTo: colorCapacityLabel.bottomAnchor, constant: 25).isActive = true
          gbStack.leadingAnchor.constraint(equalTo: circlesStack.trailingAnchor, constant: 65).isActive = true
          gbStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -53).isActive = true
        
       
        addSubview(addToCartButton)
        addToCartButton.topAnchor.constraint(equalTo: gbStack.bottomAnchor, constant: 35).isActive = true
        addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 54).isActive = true

        addSubview(addToCartLabel)
        addToCartLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 45).isActive = true
        addToCartLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor).isActive = true

        addSubview(priceLabel)
        priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor, constant: -38).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor).isActive = true
    }
    
}
