
import Foundation
import UIKit
import Cosmos

final class DetailsViewController :UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    var viewModel : DetailsViewModel?
    
    // MARK: - Initialization
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initViewModel()
        view.backgroundColor = .white
        cardView.delegate = self
        cardView.layer.zPosition = +1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
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
    var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createScrollableLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
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
        but.addTarget(self, action: #selector(backButtonPresentingVC), for: .touchUpInside)
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
    private let itemsInCartView : UIView = {
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
    private let itemsCounterLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.markProFont(size: 12, weight: .medium)
        return label
    }()
    
    // Product details label that in the top center
    private let detailsNavBarLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.markProFont(size: 18, weight: .medium)
        label.text = "Product details"
        label.textColor = .customDarkBlue
        return label
    }()
    

    //MARK:  CardView
    var cardView : CardView = {
        let card = CardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.clipsToBounds = true
        card.layer.cornerRadius = 25
        card.addShadow(radius: 7)
        card.backgroundColor = .white
        return card
    }()
    
 
    //MARK: - Button Methods
    
    // метод для кнопки backButton
    @objc func backButtonPresentingVC() {
        guard let viewModel = viewModel, let data = viewModel.dataStorage, let navigationController = navigationController else { return }
        print("InCart?:: \(data.inCart)")
        viewModel.backButtonPressed(navController: navigationController, data: data)

    }
    
    @objc func shopCartButtonPresentingVC() {
        guard let viewModel = viewModel, let data = viewModel.dataStorage, let navigationController = navigationController else { return }
        viewModel.cartButtonPressed(navController: navigationController, data: data)
    }
    
    var cartCounter : Int = 0 {
        didSet{
            setupItemsInCart()
        }
        willSet {
            itemsCounterLabel.text = String(newValue)
        }
    }
    
    //MARK: - Private Metho
    // Cart Item Counter Setup
    private func setupItemsInCart() {
        if cartCounter != 0 {
            drawCartItems()
        }
    }
    
    private func drawCartItems() {
        shopCartButton.addSubview(itemsInCartView)
        itemsInCartView.addSubview(itemsCounterLabel)
        
        itemsInCartView.topAnchor.constraint(equalTo: shopCartButton.topAnchor, constant: 2).isActive = true
        itemsInCartView.trailingAnchor.constraint(equalTo: shopCartButton.trailingAnchor, constant: -2).isActive = true
        
        itemsCounterLabel.centerXAnchor.constraint(equalTo: itemsInCartView.centerXAnchor).isActive = true
        itemsCounterLabel.centerYAnchor.constraint(equalTo: itemsInCartView.centerYAnchor, constant: -1).isActive = true
    }
}

extension DetailsViewController : CardViewResponderProtocol {
    
    func changedCapacity(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let label = sender.view as? UILabel {
                self?.cardView.gb128Label.layer.backgroundColor = (label == self?.cardView.gb128Label) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.cardView.gb256Label.layer.backgroundColor = (label == self?.cardView.gb256Label) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.cardView.gb128Label.textColor = (label == self?.cardView.gb128Label) ? .white : .gray
                self?.cardView.gb256Label.textColor = (label == self?.cardView.gb256Label) ? .white : .gray
            }
            
        })
    }
    
    func changedColor(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let label = sender.view as? UILabel {
                self?.cardView.circleLabelBrown.layer.borderColor = (label == self?.cardView.circleLabelBrown) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.cardView.circleLabelBlack.layer.borderColor = (label == self?.cardView.circleLabelBlack) ? UIColor.customOrange.cgColor : UIColor.clear.cgColor
                self?.cardView.circleLabelBrown.layer.borderWidth = (label == self?.cardView.circleLabelBrown) ? 3 : 0
                self?.cardView.circleLabelBlack.layer.borderWidth = (label == self?.cardView.circleLabelBlack) ? 3 : 0
            }
        })
    }
    
    func favoritesButtonPressed() {
        cardView.favButton.isSelected.toggle()
        if cardView.favButton.isSelected {
            cardView.favButton.setImage(UIImage(named: "heartFilled"), for: .normal)
        } else {
            cardView.favButton.setImage(UIImage(named: "heartEmpty")?.imageWithColor(color: .white), for: .normal)
        }
    }
    
    func addToCartButtonPressed() {
        cartCounter += 1
        guard let viewModel = viewModel else { return }
        viewModel.dataStorage?.inCart = true
    }
}


//MARK: - CollectionView Delegate
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identife, for: indexPath) as? DetailsCell else { fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `DetailsCell`")}
        let cellVM = viewModel?.getDetailsCellViewModel(at: indexPath)
        viewModel?.selectedIndexPath = indexPath
        cell.viewModel = cellVM
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  /*viewModel.detailsModel.count*/ 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let data = viewModel.dataStorage, let navigationController = navigationController else { return }
        viewModel.cartButtonPressed(navController: navigationController, data: data)

    }
}




//MARK: - Setup Views
extension DetailsViewController {
    //MARK:  Setup Collection View
    func setupCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identife)
        
        collectionView.isScrollEnabled = false // выключает скролл по вертикали
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    //MARK: setup UI
    func setupUI () {
        setupCardView()
    
        
    }
    
    //MARK: setup NavigationBar
    // Настройка якорей в навБаре и действий для кнопок
    func setupNavigationBar() {
        navigationItem.hidesBackButton = true

        // кнопка в корзину верх право
        view.addSubview(shopCartButton)
        shopCartButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        shopCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        view.addSubview(detailsNavBarLabel)
        detailsNavBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailsNavBarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        
        // что происходит по клику на кнопку назад
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
}

// MARK: - Creating UICollectionViewCompositionalLayout

private extension DetailsViewController {
    
    static func createScrollableLayout() -> UICollectionViewCompositionalLayout {
            let compositionalLayout: UICollectionViewCompositionalLayout = {
            
            let fractionSize: CGFloat = 0.65
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionSize),heightDimension: .fractionalWidth(fractionSize))
          
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 75, bottom: 5, trailing: 7.5)
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
