

import Foundation
import UIKit
import SwiftUI

class DetailsVC : UICollectionViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupCollectionView()
        
        setupUI()

        setupGestureRecognizer()
        
        initViewModel()
    }

        
    var viewModel = {
        DetailsViewModel()
    }()
    
    func initViewModel() {
        viewModel.getDetailsPhones()
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    // layout inizialization
    init(){
        super.init(collectionViewLayout: DetailsVC.createScrollableLayout())
    }
    
    // создаем Layout который будет туда сюда ходить
    static func createScrollableLayout() -> UICollectionViewCompositionalLayout {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            
            let fractionSize: CGFloat = 0.65
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionSize),heightDimension: .fractionalWidth(fractionSize))
          
            // Item
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 80, bottom: 0, trailing: 2.5)
            section.orthogonalScrollingBehavior = .continuous
            
            // creating transformableScrolling
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.1
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
            return UICollectionViewCompositionalLayout(section: section)
        }()
        return compositionalLayout
    }
    
    //MARK: - creating NavBar
    // кастомная кнопка назад
    lazy var backButton : UIButton = {
        let but = UIButton(type: .custom)
        but.backgroundColor = .customDarkBlue
        but.setImage(UIImage(named: "Vector"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.layer.cornerRadius = 11
        but.tintColor = .white
        but.clipsToBounds = true
        but.widthAnchor.constraint(equalToConstant: 37).isActive = true
        but.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return but
    }()
    
    // метод для кнопки backButton
    @objc func backButtonPresentingVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    lazy var shopCartButton : UIButton = {
        let but = UIButton(type: .custom)
        but.backgroundColor = .customOrange
        but.setImage(UIImage(named: "shopCart"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.layer.cornerRadius = 11
        but.clipsToBounds = true
        but.layer.shouldRasterize = false
        but.widthAnchor.constraint(equalToConstant: 37).isActive = true
        but.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return but
    }()
    
    @objc func shopCartButtonPresentingVC() {
        navigationController?.pushViewController(MyCartVC(), animated: true)
    }
    
    // Product details label that in the top center
    let detailsNavBarLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 18, weight: .medium)
        label.text = "Product details"
        label.textColor = .customDarkBlue
        return label
    }()
    
    
    //MARK: - CardView
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.snowyWhite?.cgColor
        view.layer.borderWidth = 0.5
        view.layer.shouldRasterize = false
        return view
    }()
    
    //MARK: - First Level
    // Простой контейнер для удобства заполнения
    private let firstLevelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    //Cоздаем 5 картинок звезды
    static func createStarImage () -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "star")
        image.clipsToBounds = true
        image.widthAnchor.constraint(equalToConstant:20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return image
    }
    
    let star1ImageView = createStarImage()
    let star2ImageView = createStarImage()
    let star3ImageView = createStarImage()
    let star4ImageView = createStarImage()
    let star5ImageView = createStarImage()

    //кнопка избранное
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heartEmpty"), for: .normal)
        button.layer.backgroundColor = UIColor.customDarkBlue?.cgColor
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        button.heightAnchor.constraint(equalToConstant: 37).isActive = true
        button.addTarget(self, action: #selector(didTappedFav), for: .touchUpInside)
        return button
    }()
    
    @objc func didTappedFav() {
        favButton.isSelected = !favButton.isSelected
        if favButton.isSelected {
            favButton.setImage(UIImage(named: "heartFilled"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
        }
        
    }
    
    //MARK: - Second Level
    // Простой контейнер для удобства заполнения
    private let secondLevelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //кнопки Shop, Details, Features
    private let shopLabel : UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.font = UIFont.markProFont(size: 20, weight: .heavy)
        label.textColor = .customDarkBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel : UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.font = UIFont.markProFont(size: 20, weight: .plain)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let featuresLabel : UILabel = {
        let label = UILabel()
        label.text = "Features"
        label.font = UIFont.markProFont(size: 20, weight: .plain)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // ползун под надписью
    private let underLining : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customOrange
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    //MARK: - Third Level
    
    private let thirdLevelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Label Select color and Capacity
    let colorCapacityLabel: UILabel = {
        let label = UILabel()
        label.text = "Select color and capacity"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 16, weight: .medium)
        return label
    }()
    
    // создаем лейблы 2х цветов
    let circleLabelBrown: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .brown
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.widthAnchor.constraint(equalToConstant: 39).isActive = true
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        return label
    }()
    
    let circleLabelBlack: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.widthAnchor.constraint(equalToConstant: 39).isActive = true
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        return label
    }()
    
    // создадим 2 по сути одинаковые кнопки, но одна будет нажата, а другая нет
    
    lazy var gb128Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .customOrange
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

        return label
    }()
    
    lazy var gb256Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.markProFont(size: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.text = "256 GB"
        label.widthAnchor.constraint(equalToConstant: 71).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.isUserInteractionEnabled = true

        return label
    }()
    
    // это надо потом во вью модель
    @objc func changeLabelColor(sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            if label == gb128Label { // выбран первый лейбл (128гб)
   
                    self.gb128Label.backgroundColor = .customOrange
                    self.gb256Label.backgroundColor = .clear
                    self.gb128Label.textColor = .white
                    self.gb256Label.textColor = .gray
               
            } else {
          
                    // выбран второй лейбл (256гб)
                gb256Label.backgroundColor = .customOrange
                gb128Label.backgroundColor = .clear
                gb256Label.textColor = .white
                gb128Label.textColor = .gray
                
            }
        }
    }
    
    // и это тож во вью модель
    func setupGestureRecognizer() {
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(changeLabelColor))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(changeLabelColor))
        gb256Label.addGestureRecognizer(tapGesture2)
        gb128Label.addGestureRecognizer(tapGesture1)

        tapGesture1.delegate = self
        tapGesture2.delegate = self
    }
    
    
    
    
    //MARK: - Fourth Level
    
    private let forthLevelView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //добавляет Label Add to Cart в кнопке
    lazy var addToCartLabel: UILabel = {
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
    lazy var priceLabel: UILabel = {
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
        let button = UIButton()
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.shouldRasterize = false
        return button
    }()
    
    // Чтобы не  писать кучу строк кода, попробую написать функцию 1)создающую имейджВьюхи и 2)текстовые лейблы
    
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
    static let memoryStack = makeVerticalStack(image: memoryCardImage, label: memoryCardLabel)
    static let operativkaStack = makeVerticalStack(image: operativkaImage, label: operativkaLabel)
    static let cameraStack = makeVerticalStack(image: cameraOptionsImage, label: cameraOptionsLabel)
    static let processorStack = makeVerticalStack(image: processorImage, label: processorLabel)
    
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
    
    let optionsStack = makeHorizontalStackOfStacks(stack1: memoryStack, stack2: operativkaStack, stack3: cameraStack, stack4: processorStack)
    
    
    // Делаем функцию, создающую стак для кнопки
    private func makeButtonStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //.axis = .horizontal
        //stackView.distribution = .equalSpacing
        //stackView.alignment = .center
        stackView.backgroundColor = .clear
        return stackView
    }
    
    // делаем функцию для стака звезд
    private func makeStartsStackView() -> UIStackView {
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


  

    //MARK: - setup UI
    //настройка якорей
    func setupUI () {
        setupNavigationBar()
        
        setupCardView()
        setupFirstLevel()
        setupSecondLevel()
        setupThirdLevel()
        setupFourthLevel()
    }
    
    // Настройка якорей в навБаре и действий для кнопок
    func setupNavigationBar() {
        view.addSubview(detailsNavBarLabel)
        view.addSubview(shopCartButton)
    
        detailsNavBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailsNavBarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        
        // кнопка в корзину верх право
        shopCartButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        shopCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        navigationItem.hidesBackButton = true

        // что происходит по клику на кнопку назад
        backButton.addTarget(self, action: #selector(backButtonPresentingVC), for: .touchUpInside)
        let backBarButtonItems = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItems
        
        // что происходит по клику на корзину
        let rightBarButton = UIBarButtonItem(customView: shopCartButton)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        shopCartButton.addTarget(self, action: #selector(shopCartButtonPresentingVC), for: .touchUpInside)
    }
    
    func setupCardView() {
        view.addSubview(cardView)
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
    }
    
    func setupFirstLevel() {
        cardView.addSubview(firstLevelView)
        firstLevelView.addSubview(phoneLabel)
        firstLevelView.addSubview(favButton)
        let addStarsStuck = makeStartsStackView()
        addStarsStuck.addArrangedSubview(star1ImageView)
        addStarsStuck.addArrangedSubview(star2ImageView)
        addStarsStuck.addArrangedSubview(star3ImageView)
        addStarsStuck.addArrangedSubview(star4ImageView)
        addStarsStuck.addArrangedSubview(star5ImageView)
        firstLevelView.addSubview(addStarsStuck)

        firstLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        firstLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        firstLevelView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        firstLevelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: firstLevelView.topAnchor, constant: 20).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: firstLevelView.leadingAnchor, constant: 30).isActive = true
        
        addStarsStuck.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 6).isActive = true
        addStarsStuck.leadingAnchor.constraint(equalTo: firstLevelView.leadingAnchor, constant: 30).isActive = true
        
        favButton.topAnchor.constraint(equalTo: firstLevelView.topAnchor, constant: 28).isActive = true
        favButton.trailingAnchor.constraint(equalTo: firstLevelView.trailingAnchor, constant: -40).isActive = true
    }
    
    func setupSecondLevel() {
        cardView.addSubview(secondLevelView)
        secondLevelView.addSubview(underLining)
        secondLevelView.addSubview(optionsStack)
      
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(shopLabel)
        stack.addArrangedSubview(detailsLabel)
        stack.addArrangedSubview(featuresLabel)
        secondLevelView.addSubview(stack)
        
        secondLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        secondLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        secondLevelView.topAnchor.constraint(equalTo: firstLevelView.bottomAnchor).isActive = true
        secondLevelView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        stack.topAnchor.constraint(equalTo: secondLevelView.topAnchor, constant: 20).isActive = true
        stack.leadingAnchor.constraint(equalTo: secondLevelView.leadingAnchor, constant: 30).isActive = true
        stack.trailingAnchor.constraint(equalTo: secondLevelView.trailingAnchor, constant: -30).isActive = true
        stack.centerXAnchor.constraint(equalTo: secondLevelView.centerXAnchor).isActive = true
        
        underLining.leadingAnchor.constraint(equalTo: secondLevelView.leadingAnchor, constant: 30).isActive = true
        underLining.widthAnchor.constraint(equalTo: shopLabel.widthAnchor).isActive = true
        underLining.heightAnchor.constraint(equalToConstant: 3).isActive = true
        underLining.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 3).isActive = true
        
        optionsStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 35).isActive = true
        optionsStack.leadingAnchor.constraint(equalTo: secondLevelView.leadingAnchor, constant: 30).isActive = true
        optionsStack.trailingAnchor.constraint(equalTo: secondLevelView.trailingAnchor, constant: -30).isActive = true
     
        
    }
    
    func setupThirdLevel() {
        cardView.addSubview(thirdLevelView)
        thirdLevelView.addSubview(colorCapacityLabel)
        
        //стак для кругляшек
        let circlesStack = circlesStack()
        circlesStack.addArrangedSubview(circleLabelBrown)
        circlesStack.addArrangedSubview(circleLabelBlack)
        thirdLevelView.addSubview(circlesStack)

        //стак для гигов
        let gbStack = makeStartsStackView()
        gbStack.addArrangedSubview(gb128Label)
        gbStack.spacing = 6
        gbStack.addArrangedSubview(gb256Label)
        thirdLevelView.addSubview(gbStack)
        
        
        thirdLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        thirdLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        thirdLevelView.topAnchor.constraint(equalTo: secondLevelView.bottomAnchor).isActive = true
        thirdLevelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        colorCapacityLabel.topAnchor.constraint(equalTo: thirdLevelView.topAnchor, constant: 5).isActive = true
        colorCapacityLabel.leadingAnchor.constraint(equalTo: thirdLevelView.leadingAnchor, constant: 30).isActive = true
        
        circlesStack.leadingAnchor.constraint(equalTo: thirdLevelView.leadingAnchor, constant: 30).isActive = true
        circlesStack.bottomAnchor.constraint(equalTo: thirdLevelView.bottomAnchor, constant: -16).isActive = true
        
        gbStack.bottomAnchor.constraint(equalTo: thirdLevelView.bottomAnchor, constant: -16).isActive = true
        gbStack.leadingAnchor.constraint(equalTo: circlesStack.trailingAnchor, constant: 55).isActive = true
        gbStack.trailingAnchor.constraint(equalTo: thirdLevelView.trailingAnchor, constant: -63).isActive = true
        
    }
    
    func setupFourthLevel() {
        cardView.addSubview(forthLevelView)
        forthLevelView.addSubview(addToCartButton)
        forthLevelView.addSubview(addToCartLabel)
        forthLevelView.addSubview(priceLabel)
    
        forthLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        forthLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        forthLevelView.topAnchor.constraint(equalTo: thirdLevelView.bottomAnchor).isActive = true
        forthLevelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addToCartButton.bottomAnchor.constraint(equalTo: forthLevelView.bottomAnchor, constant: -35).isActive = true
        addToCartButton.leadingAnchor.constraint(equalTo: forthLevelView.leadingAnchor, constant: 30).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: forthLevelView.trailingAnchor, constant: -30).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        addToCartLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 45).isActive = true
        addToCartLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor, constant: -38).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor).isActive = true

    }
  
    func setupCollectionView () {
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identife)
        collectionView.isScrollEnabled = false // выключает скролл по вертикали
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}



//MARK: - CollectionView Delegate
extension DetailsVC {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identife, for: indexPath) as? DetailsCell else { fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ProductDetailsCustomCell`")}
        let cellVM = viewModel.getDetailsCellViewModel(at: indexPath) as? DetailsCellModelProtocol
        cell.viewModel = cellVM
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.addShadow()
        print("Setting cell with indexPath: \(indexPath), cellVM: \(cellVM)")
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return /*viewModel.detailsModel.count ??*/ 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MyCartVC()
        navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
     
    }
}

//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        Group {
//            ProductDetailsVC().showPreview()
//            ProductDetailsVC().showPreview()
//        }
//    }
//}






