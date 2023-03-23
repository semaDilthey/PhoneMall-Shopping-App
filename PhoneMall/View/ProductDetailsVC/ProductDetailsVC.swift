

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
        view.layer.shouldRasterize = true
        return view
    }()
    //добавляет Label Add to Cart в кнопке
    lazy var addLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.text = "ADD TO CART"
        return label
    }()
    // добавляет цену в кнопке
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.text = "1500"
        return label
    }()
    // добавляет кнопку
    lazy var addToCartButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 7
        return button
    }()
    
    // Лейбл с названием телефона
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.font = UIFont(name: "MarkPro-Medium", size: 24)
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Galaxy Note 20 Ultra", attributes: [NSAttributedString.Key.kern: -0.33])
        return label
    }()
    //Cоздаем 5 картинок звезды
    lazy var star1ImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "star")
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    lazy var star2ImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "star")
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    lazy var star3ImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "star")
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    lazy var star4ImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "star")
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    lazy var star5ImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "star")
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    //кнопка избранное
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favIcon"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 37, height: 33)
        button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    //кнопки Shop, Details, Features
    lazy var shopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 20)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "Shop", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
        
    }()
    lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 20)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "Details", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
    }()
    lazy var featuresButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 20)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "Features", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
    }()
    // создаем лейблы 2х цветов
    lazy var circleLabelBrown: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .brown
        label.clipsToBounds = true
        label.frame = CGRect(x:0 , y: 0, width: 39, height: 39)
        label.layer.cornerRadius = 20
        return label
    }()
    
    lazy var circleBlacklBrown: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.frame = CGRect(x:0 , y: 0, width: 39, height: 39)
        label.layer.cornerRadius = 20
        return label
    }()
    
    // создадим 2 по сути одинаковые кнопки, но одна будет нажата, а другая нет
    
    lazy var gb128Button: UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor(named: "customOrange")?.cgColor
        button.layer.cornerRadius = 4
        button.layer.frame = CGRect(x: 0, y: 0, width: 71, height: 30)
        button.font = UIFont(name: "DSLCLU+MarkPro-Medium", size: 13)
        button.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.textAlignment = .center
        button.attributedText =  NSMutableAttributedString(string: "128 GB", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
    }()
    
    lazy var gb256Button: UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.layer.cornerRadius = 4
        button.frame = CGRect(x: 0, y: 0, width: 71, height: 30)
        button.font = UIFont(name: "DSLCLU+MarkPro-Medium", size: 13)
        button.textColor = UIColor(red: 0.554, green: 0.554, blue: 0.554, alpha: 1)
        button.textAlignment = .center
        button.attributedText = NSMutableAttributedString(string: "128 GB", attributes: [NSAttributedString.Key.kern: -0.33])
        return button
    }()
    
    // Чтобы не  писать кучу строк кода, попробую написать функцию 1)создающую имейджВьюхи и 2)текстовые лейблы
    
    static func createImagePhoneOptions (name: String, width: Int, height: Int) -> UIImageView { // создает картинку
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: name)
        image.frame = CGRect(x: 0, y: 0, width: width, height: height)
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
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "MarkPro-Regular", size: 11)
        label.textColor = UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)
        return label
    }
    // объекты картинок
    static let processorImage = createImagePhoneOptions(name: "processor", width: 22, height: 22)
    static let operativkaImage = createImagePhoneOptions(name: "operativka", width: 28, height: 22)
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
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 5
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
        stack.alignment = .lastBaseline
        stack.spacing = 30
        stack.backgroundColor = .clear
        stack.addArrangedSubview(stack1)
        stack.addArrangedSubview(stack2)
        stack.addArrangedSubview(stack3)
        stack.addArrangedSubview(stack4)
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
        stackView.spacing = 210
        stackView.backgroundColor = .clear
        return stackView
    }
    
    // делаем функцию для стака звезд
    private func makeStartsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = .pi
        stackView.backgroundColor = .clear
        return stackView
    }
    
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
        
        //стак для гигов
        let gbStack = makeStartsStackView()
        gbStack.addArrangedSubview(gb128Button)
        gbStack.addArrangedSubview(gb256Button)
        someView.addSubview(gbStack)
        
        // закидываем phoneLabel и прочиее на вью
        someView.addSubview(phoneLabel) // phone label
        someView.addSubview(favButton) // favorites button
        someView.addSubview(circleLabelBrown) // brown circle
        someView.addSubview(circleBlacklBrown) // black circle
        someView.addSubview(optionsStack)
        
        // констрейнты
        NSLayoutConstraint.activate([
            // для вью
            someView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            someView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            someView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            someView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            // для кнопки
            addToCartButton.bottomAnchor.constraint(equalTo: someView.bottomAnchor, constant: -35),
            addToCartButton.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -10),
            // для лейблов в стаке кнопки
            addLabel.leadingAnchor.constraint(equalTo: addButtonStuck.leadingAnchor, constant: 10),
            addLabel.topAnchor.constraint(equalTo: addButtonStuck.topAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: addButtonStuck.trailingAnchor, constant: -10),
            // лейбл названия телефон
            phoneLabel.topAnchor.constraint(equalTo: someView.topAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 20),
            // стак звезд
            addStarsStuck.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 2),
            addStarsStuck.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 20),
            // для кнопки избранного
            favButton.topAnchor.constraint(equalTo: someView.topAnchor, constant: 20),
            favButton.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -20),
            
            // для стака шоп детаилс фючерс
            addSDFStuck.topAnchor.constraint(equalTo: addStarsStuck.bottomAnchor, constant: 15),
            addSDFStuck.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 20),
            addSDFStuck.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -20),
            
            // для стака кругляшей с выбором цвета
            circleLabelBrown.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -15),
            circleLabelBrown.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 20),
            circleLabelBrown.widthAnchor.constraint(equalToConstant: 39),
            circleLabelBrown.heightAnchor.constraint(equalToConstant: 39),
            
            circleBlacklBrown.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -15),
            circleBlacklBrown.leadingAnchor.constraint(equalTo: circleLabelBrown.trailingAnchor, constant: 10),
            circleBlacklBrown.widthAnchor.constraint(equalToConstant: 39),
            circleBlacklBrown.heightAnchor.constraint(equalToConstant: 39),
            // стак для проца, памяти, фото и оперативки
            optionsStack.topAnchor.constraint(equalTo: someView.topAnchor, constant: 183),
            optionsStack.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30),
            optionsStack.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -40),
            optionsStack.heightAnchor.constraint(equalToConstant: 70),
            
            // стак для гигов сюда
            gbStack.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -15),
            gbStack.leadingAnchor.constraint(equalTo: circleBlacklBrown.trailingAnchor, constant: 55),
            gbStack.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -63)
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
        return 8
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
