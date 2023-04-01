

import Foundation
import UIKit
import SwiftUI

class ProductDetailsVC : UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ProductDetailsCustomCell.self, forCellWithReuseIdentifier: ProductDetailsCustomCell.identife)
        view.addSubview(someView)
        someView.addSubview(addToCartButton)
        collectionView.isScrollEnabled = false // выключает скролл по вертикали 
        setupVIew()
        
    }
    
    // layout inizialization
    init(){
        super.init(collectionViewLayout: ProductDetailsVC.createScrollableLayout())
    }
    
    // создаем Layout который будет туда сюда ходить
            static func createScrollableLayout() -> UICollectionViewCompositionalLayout {
            let compositionalLayout: UICollectionViewCompositionalLayout = {
                let fraction: CGFloat = 4.0 / 8.0
                
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalWidth(fraction))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 2.5)
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
    
    //MARK: - Создаем кастомную вью под коллекшеном вью
    lazy var someView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 4
        view.layer.shadowOffset = .init(width: 0, height: 2)
        view.layer.shadowRadius = 15
        view.layer.shouldRasterize = false
        return view
    }()
    
    
    // Лейбл с названием телефона
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.font = UIFont.markProFont(size: 22, weight: .medium)
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Galaxy Note 20 Ultra", attributes: [NSAttributedString.Key.kern: -0.33])
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
        image.backgroundColor = .clear
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
        button.setImage(UIImage(named: "favIcon"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        button.heightAnchor.constraint(equalToConstant: 33).isActive = true
        button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    //кнопки Shop, Details, Features
    
    static func createShopDetailsFeaturesButton(string : String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.markProFont(size: 20, weight: .heavy)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.titleLabel?.textAlignment = .center
//        button.titleLabel?.attributedText = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.kern: -0.33])
        button.setTitle(string, for: .normal)
        return button
    }
    let shopButton = createShopDetailsFeaturesButton(string: "Shop")
    let detailsButton = createShopDetailsFeaturesButton(string: "Details")
    let featuresButton = createShopDetailsFeaturesButton(string: "Features")
        

    
    // Label Select color and Capacity
    
    let colorCapacityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
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
        label.widthAnchor.constraint(equalToConstant: 39).isActive = true
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    lazy var circleLabelBlack: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.widthAnchor.constraint(equalToConstant: 39).isActive = true
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    // создадим 2 по сути одинаковые кнопки, но одна будет нажата, а другая нет
    
    lazy var gb128Button: UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor(named: "customOrange")?.cgColor
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalToConstant: 71).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.font = UIFont.markProFont(size: 12, weight: .medium)
        button.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.textAlignment = .center
        button.attributedText =  NSMutableAttributedString(string: "128 GB", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
    }()
    
    lazy var gb256Button: UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalToConstant: 71).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.font = UIFont.markProFont(size: 12, weight: .medium)
        button.textColor = UIColor(red: 0.554, green: 0.554, blue: 0.554, alpha: 1)
        button.textAlignment = .center
        button.attributedText = NSMutableAttributedString(string: "256 GB", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
    }()
    
    //добавляет Label Add to Cart в кнопке
    lazy var addLabel: UILabel = {
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
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 20
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
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
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
    func setupVIew () {
        
        // стак для кнопки
        let addButtonStuck = makeButtonStackView()
        addButtonStuck.addArrangedSubview(addLabel)
        addButtonStuck.addArrangedSubview(priceLabel)
        addToCartButton.addSubview(addButtonStuck)
        
        //стак для звезд
        let addStarsStuck = makeStartsStackView()
        addStarsStuck.addArrangedSubview(star1ImageView)
        addStarsStuck.addArrangedSubview(star2ImageView)
        addStarsStuck.addArrangedSubview(star3ImageView)
        addStarsStuck.addArrangedSubview(star4ImageView)
        addStarsStuck.addArrangedSubview(star5ImageView)
        someView.addSubview(addStarsStuck)
        
        // стак для shop, details, features
        let addSDFStuck = makeStartsStackView()
        addSDFStuck.addArrangedSubview(shopButton)
        addSDFStuck.addArrangedSubview(detailsButton)
        addSDFStuck.addArrangedSubview(featuresButton)
        someView.addSubview(addSDFStuck)
        
        //стак для кругляшек
        let circlesStack = circlesStack()
        circlesStack.addArrangedSubview(circleLabelBrown)
        circlesStack.addArrangedSubview(circleLabelBlack)
        someView.addSubview(circlesStack)

        //стак для гигов
        let gbStack = makeStartsStackView()
        gbStack.addArrangedSubview(gb128Button)
        gbStack.addArrangedSubview(gb256Button)
        someView.addSubview(gbStack)
        
        // закидываем phoneLabel и прочиее на вью
        someView.addSubview(phoneLabel) // phone label
        someView.addSubview(favButton) // favorites button
        someView.addSubview(colorCapacityLabel)
        someView.addSubview(optionsStack)
        
        
        // констрейнты
        NSLayoutConstraint.activate([
            // для вью
            someView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            someView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            someView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            someView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400)
           ])
        // лейбл названия телефон
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: someView.topAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30)
            ])
        // стак звезд
        NSLayoutConstraint.activate([
            addStarsStuck.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 6),
            addStarsStuck.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30)
            ])
        // для кнопки избранного
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: someView.topAnchor, constant: 28),
            favButton.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -40)
            ])
        // для стака шоп детаилс фючерс
        NSLayoutConstraint.activate([
            addSDFStuck.topAnchor.constraint(equalTo: addStarsStuck.topAnchor, constant: 32),
            addSDFStuck.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 20),
            addSDFStuck.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -30),
            addSDFStuck.centerXAnchor.constraint(equalTo: someView.centerXAnchor)
            ])
        // стак для проца, памяти, фото и оперативки
        NSLayoutConstraint.activate([
            optionsStack.topAnchor.constraint(equalTo: addSDFStuck.bottomAnchor, constant: 43),
            optionsStack.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30),
            optionsStack.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -30)
            ])
        // для лейбла Select color and capacity
        NSLayoutConstraint.activate([
            colorCapacityLabel.topAnchor.constraint(equalTo: optionsStack.bottomAnchor, constant: 29),
            colorCapacityLabel.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30)
        ])
            
            
//
            // для стака кругляшей с выбором цвета
        NSLayoutConstraint.activate([
            circlesStack.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30),
            circlesStack.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -27),
            
            
            ])
       
            // стак для гигов сюда
        NSLayoutConstraint.activate([
            gbStack.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -27),
            gbStack.leadingAnchor.constraint(equalTo: circlesStack.trailingAnchor, constant: 55),
            gbStack.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -63),
        ])
        
        // для кнопки
    NSLayoutConstraint.activate([
        addToCartButton.bottomAnchor.constraint(equalTo: someView.bottomAnchor, constant: -35),
        addToCartButton.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30),
        addToCartButton.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -30),
        addToCartButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        // для лейблов в стаке кнопки
    NSLayoutConstraint.activate([
        addLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 45),
        addLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
        
        priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor, constant: -38)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - скока секций
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //MARK: - какая ячейка тама будет
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailsCustomCell.identife, for: indexPath) as? ProductDetailsCustomCell else { fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ProductDetailsCustomCell`")}
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        
        return cell
    }
    //MARK: - Количество объектов в скроле
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    //MARK: - чо будет по клику на ячейку
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = UIViewController()
//        print("This cell #\(indexPath.row) located in section #\(indexPath.section)")
//        vc.view.backgroundColor = indexPath.section == 0 ? .yellow : .systemGray
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = MyCartVC()
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
}

struct ViewControllerProvider : PreviewProvider {
    static var previews: some View {
        ProductDetailsVC().showPreview()
    }
}
