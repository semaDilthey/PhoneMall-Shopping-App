

import Foundation
import UIKit
import SwiftUI
import Cosmos

final class DetailsVC : UICollectionViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    var localData : DataStorage?
    var viewModel : DetailsViewModel?
        
    var cartCounter : Int = 0 {
        didSet{
            setupItemsInCart()
        }
        willSet {
            itemsCounterLabel.text = String(newValue)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Initialization
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        self.localData = viewModel.dataStorage
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ViewModel Initialization
    private func initViewModel() {
        viewModel?.getDetailsPhones()
        viewModel?.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
 
    // MARK: - UI Elements
    //MARK:  creating NavBar
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
    
    // view под каунтер корзины
    var itemsInCartView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        view.heightAnchor.constraint(equalToConstant: 16).isActive = true
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .customOrange
        return view
    }()
    
    // сам каунтер в корзине
    var itemsCounterLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.markProFont(size: 12, weight: .medium)
        return label
    }()
    
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
    

    //MARK:  CardView
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.snowyWhite?.cgColor
        view.layer.borderWidth = 0.5
        view.layer.shouldRasterize = false
        view.dropShadow()
        return view
    }()
    
    //MARK:  First Level
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
    
    
    //MARK:  Second Level
    // Простой контейнер для удобства заполнения
    private let secondLevelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
               self?.collectionView.layoutIfNeeded()
           })
       }

    
    //MARK: - Third Level
    private let thirdLevelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    
    //MARK: - Fourth Level
    
    private let forthLevelView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    // метод для кнопки backButton
    @objc func backButtonPresentingVC() {
        guard let data = localData else { return }
        viewModel?.backButtonPressed(navController: navigationController!, data: data)

    }
    
    @objc func shopCartButtonPresentingVC() {
        guard let data = viewModel?.dataStorage else { return }
        viewModel?.cartButtonPressed(navController: navigationController!, data: data)
    }
    
    
    @objc func didTappedFav() {
        favButton.isSelected.toggle()
        favButton.isSelected ? favButton.setImage(UIImage(named: "heartFilled"), for: .normal) : favButton.setImage(UIImage(named: "heartEmpty")?.imageWithColor(color: .white), for: .normal)
    }
    
    // это надо потом во вью модель
    @objc func changedCapacity(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let label = sender.view as? UILabel {
                self?.gb128Label.layer.backgroundColor = (label == self?.gb128Label) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.gb256Label.layer.backgroundColor = (label == self?.gb256Label) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.gb128Label.textColor = (label == self?.gb128Label) ? .white : .gray
                self?.gb256Label.textColor = (label == self?.gb256Label) ? .white : .gray
            }
            
        })
    }
    
    @objc func changedColor(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let label = sender.view as? UILabel {
                self?.circleLabelBrown.layer.borderColor = (label == self?.circleLabelBrown) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.circleLabelBlack.layer.borderColor = (label == self?.circleLabelBlack) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.circleLabelBrown.layer.borderWidth = (label == self?.circleLabelBrown) ? 3 : 0
                self?.circleLabelBlack.layer.borderWidth = (label == self?.circleLabelBlack) ? 3 : 0
            }
        })
    }
    
    @objc func addToCartButtonTapped() {
        cartCounter += 1
        // Закидываем телефоны в массив phonesInCart в файле MyCartViewMode.
        localData?.inCart = true
    }
       
    //MARK: - Private Metho
    // Cart Item Counter Setup
    private func setupItemsInCart() {
        if cartCounter != 0 {
            shopCartButton.addSubview(itemsInCartView)
            itemsInCartView.addSubview(itemsCounterLabel)
            
            itemsInCartView.topAnchor.constraint(equalTo: shopCartButton.topAnchor, constant: 2).isActive = true
            itemsInCartView.trailingAnchor.constraint(equalTo: shopCartButton.trailingAnchor, constant: -2).isActive = true
            
            itemsCounterLabel.centerXAnchor.constraint(equalTo: itemsInCartView.centerXAnchor).isActive = true
            itemsCounterLabel.centerYAnchor.constraint(equalTo: itemsInCartView.centerYAnchor, constant: -1).isActive = true
        }
    }
}

// MARK: создаем Layout который будет туда сюда ходить
private extension DetailsVC {
    
    func createScrollableLayout() -> UICollectionViewCompositionalLayout {
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
    
}

//MARK: - CollectionView Delegate
extension DetailsVC {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identife, for: indexPath) as? DetailsCell else { fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ProductDetailsCustomCell`")}
        let cellVM = viewModel?.getDetailsCellViewModel(at: indexPath)
        viewModel?.selectedIndexPath = indexPath
        cell.viewModel = cellVM
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  /*viewModel.detailsModel.count*/ 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = localData else { return }
        viewModel?.cartButtonPressed(navController: navigationController!, data: data)

    }
}

//MARK: - Setup Views
extension DetailsVC {
    //MARK:  Setup Collection View
    func setupCollectionView () {
        collectionView.collectionViewLayout = createScrollableLayout()
        
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identife)
        collectionView.isScrollEnabled = false // выключает скролл по вертикали
        
    }
    
    //MARK: setup UI
    func setupUI () {
        setupCardView()
        
        setupFirstLevel()
        setupSecondLevel()
        setupThirdLevel()
        setupFourthLevel()
        
    }
    
    //MARK: setup NavigationBar
    // Настройка якорей в навБаре и действий для кнопок
    func setupNavigationBar() {
        
        // кнопка в корзину верх право
        view.addSubview(shopCartButton)
        shopCartButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        shopCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        view.addSubview(detailsNavBarLabel)
        detailsNavBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailsNavBarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        
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
    
    //MARK: setup CardView
    func setupCardView() {
        
        view.addSubview(cardView)
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        
    }
    
    //MARK: setup 1st Level
    func setupFirstLevel() {
        
        cardView.addSubview(firstLevelView)
        firstLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        firstLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        firstLevelView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        firstLevelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        firstLevelView.addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: firstLevelView.topAnchor, constant: 20).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: firstLevelView.leadingAnchor, constant: 30).isActive = true
        
        firstLevelView.addSubview(favButton)
        favButton.topAnchor.constraint(equalTo: firstLevelView.topAnchor, constant: 28).isActive = true
        favButton.trailingAnchor.constraint(equalTo: firstLevelView.trailingAnchor, constant: -40).isActive = true
        
        firstLevelView.addSubview(cosmosView)
        cosmosView.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 6).isActive = true
        cosmosView.leadingAnchor.constraint(equalTo: firstLevelView.leadingAnchor, constant: 30).isActive = true
        
        cosmosView.didTouchCosmos = { _ in
            self.cosmosView.text = ""
            
        }
    }
    
    //MARK: setup 2nd Level
    func setupSecondLevel() {
        
        cardView.addSubview(secondLevelView)
        secondLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        secondLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        secondLevelView.topAnchor.constraint(equalTo: firstLevelView.bottomAnchor).isActive = true
        secondLevelView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        secondLevelView.addSubview(segmentedControlContainerView)
        NSLayoutConstraint.activate([
                    segmentedControlContainerView.topAnchor.constraint(equalTo: secondLevelView.topAnchor, constant: 20),
                    segmentedControlContainerView.leadingAnchor.constraint(equalTo: secondLevelView.leadingAnchor, constant: 30),
                    segmentedControlContainerView.trailingAnchor.constraint(equalTo: secondLevelView.trailingAnchor, constant: -30),
                    segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
                    ])
        
        secondLevelView.addSubview(optionsStack)
        optionsStack.topAnchor.constraint(equalTo: segmentedControlContainerView.bottomAnchor, constant: 35).isActive = true
        optionsStack.leadingAnchor.constraint(equalTo: secondLevelView.leadingAnchor, constant: 30).isActive = true
        optionsStack.trailingAnchor.constraint(equalTo: secondLevelView.trailingAnchor, constant: -30).isActive = true
        
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
        
    }
    
    //MARK: setup 3rd Level
    func setupThirdLevel() {
        
        cardView.addSubview(thirdLevelView)
        thirdLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        thirdLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        thirdLevelView.topAnchor.constraint(equalTo: secondLevelView.bottomAnchor).isActive = true
        thirdLevelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        thirdLevelView.addSubview(colorCapacityLabel)
        colorCapacityLabel.topAnchor.constraint(equalTo: thirdLevelView.topAnchor, constant: 5).isActive = true
        colorCapacityLabel.leadingAnchor.constraint(equalTo: thirdLevelView.leadingAnchor, constant: 30).isActive = true
        
        //стак для кругляшек
        let circlesStack = circlesStack()
        circlesStack.addArrangedSubview(circleLabelBrown)
        circlesStack.addArrangedSubview(circleLabelBlack)
        circlesStack.spacing = 15
        
        thirdLevelView.addSubview(circlesStack)
        circlesStack.leadingAnchor.constraint(equalTo: thirdLevelView.leadingAnchor, constant: 30).isActive = true
        circlesStack.bottomAnchor.constraint(equalTo: thirdLevelView.bottomAnchor, constant: -16).isActive = true

        //стак для гигов
        let gbStack = giggabytesStack()
        gbStack.addArrangedSubview(gb128Label)
        gbStack.spacing = 12
        gbStack.addArrangedSubview(gb256Label)
        
        thirdLevelView.addSubview(gbStack)
        gbStack.bottomAnchor.constraint(equalTo: thirdLevelView.bottomAnchor, constant: -16).isActive = true
        gbStack.leadingAnchor.constraint(equalTo: circlesStack.trailingAnchor, constant: 65).isActive = true
        gbStack.trailingAnchor.constraint(equalTo: thirdLevelView.trailingAnchor, constant: -53).isActive = true
        
    }
    
    //MARK: setup 4th Level
    func setupFourthLevel() {
        
        cardView.addSubview(forthLevelView)
        forthLevelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        forthLevelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        forthLevelView.topAnchor.constraint(equalTo: thirdLevelView.bottomAnchor).isActive = true
        forthLevelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        forthLevelView.addSubview(addToCartButton)
        addToCartButton.bottomAnchor.constraint(equalTo: forthLevelView.bottomAnchor, constant: -35).isActive = true
        addToCartButton.leadingAnchor.constraint(equalTo: forthLevelView.leadingAnchor, constant: 30).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: forthLevelView.trailingAnchor, constant: -30).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        forthLevelView.addSubview(addToCartLabel)
        addToCartLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 45).isActive = true
        addToCartLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor).isActive = true
        
        forthLevelView.addSubview(priceLabel)
        priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor, constant: -38).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor).isActive = true
    }
  
    
}

//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        Group {
//            DetailsVC().showPreview()
//        }
//    }
//}






