

import Foundation
import UIKit
import SwiftUI


final class MyCartVC : UIViewController, CartCellDelegate {
  
    // MARK: - Properties
    let viewModel : MyCartViewModel?
    
    // property observer, считает тотал
    var totalPriceObserver : Double = 0.0 {
        willSet {
            getTotalPrice()
        }
    }
    
    var checkingOut : Bool {
        checkoutButton.isTouchInside ? true : false
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initViewModel()
    }
    
    // MARK: - Initialization
    init(viewModel: MyCartViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewModel Initialization
    func initViewModel() {
        viewModel?.getCartPhones()
        viewModel?.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Elements
    // NavBar
    lazy var backButton : UIButton = {
        let but = UIButton(type: .custom)
        but.backgroundColor = .customDarkBlue
        but.setImage(UIImage(named: "Vector"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.widthAnchor.constraint(equalToConstant: 37).isActive = true
        but.heightAnchor.constraint(equalToConstant: 37).isActive = true
        but.layer.cornerRadius = 11
        but.tintColor = .white
        but.clipsToBounds = true
        but.addTarget(self, action: #selector(backToHomeVC), for: .touchUpInside)
//        
        let backBarButtonItems = UIBarButtonItem(customView: but)
        navigationItem.leftBarButtonItem = backBarButtonItems
        navigationItem.hidesBackButton = true
        return but
    }()
    
    lazy var addressButton : UIButton = {
        let but = UIButton()
        but.backgroundColor = .customOrange
        but.setImage(UIImage(named: "addressButton"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.widthAnchor.constraint(equalToConstant: 37).isActive = true
        but.heightAnchor.constraint(equalToConstant: 37).isActive = true
        but.layer.cornerRadius = 11
        but.clipsToBounds = true
        return but
    }()
    
    private let addAdressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add address"
        label.textColor = .black
        label.font = UIFont.markProFont(size: 16, weight: .medium)
        return label
    }()
    
    private let myCartLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Cart"
        label.font = UIFont.markProFont(size: 30, weight: .heavy)
        label.textColor = UIColor(named: "customDarkBlue")
        return label
    }()
    
    // Добавляем вью, на которую закинием tableView
    private let cardView : UIView = { // non scrollable, just view
        let scroll = UIView()
        scroll.backgroundColor = .customDarkBlue
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.clipsToBounds = true
        scroll.layer.cornerRadius = 15
        return scroll
    }()
    
     private lazy var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .customDarkBlue
        table.layer.cornerRadius = 15
        table.dataSource = self
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // округляет только левый верхний и правый углы через cornerRadius
        table.clipsToBounds = true
        table.register(MyCartCell.self, forCellReuseIdentifier: MyCartCell.identifire)
        return table
    }()
    
    // линия над Total
    private let lineUpper : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // линия под total/Delivery
    private let lineLower : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var totalPrice : UILabel = {
        let label = UILabel()
        label.font = .markProFont(size: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$ 2326.0"
        label.textColor = .white
        return label
    }()
    
    private let totalLabel : UILabel = {
        let label = UILabel()
        label.font = .markProFont(size: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total"
        label.textColor = .white
        return label
    }()
    
    private let deliveryLabel : UILabel = {
        let label = UILabel()
        label.font = .markProFont(size: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delivery"
        label.textColor = .white
        return label
    }()
    
    var deliveryPrice : UILabel = {
        let label = UILabel()
        label.font = .markProFont(size: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Free"
        label.textColor = .white
        return label
    }()
  
    // c
    private let StackTotalPrice : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let StackDeliveryCost : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var checkoutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .customOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.markProFont(size: 20, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitle("Checkout", for: .normal)
        button.startAnimatingPressActions()
        // giving a config to style our button
        configureButton(button: button)
        return button
    }()
    
    
    //MARK: - Button Methods
    
    @objc func backToHomeVC() {
        guard let viewModel = viewModel, let dataStorage = viewModel.dataStorage else { return }
        viewModel.backButtonPressed(navController: navigationController!, dataStorage: dataStorage)
    }
    
    func didTapDeleteButton(cell: MyCartCell) {
        viewModel?.deleteTapped(cell: cell, tableView: tableView)
    }
    
    
    //MARK: - Private Methods
    
    private func getTotalPrice() {
        guard let viewModel = viewModel else { return }
        if viewModel.cartPhonesModel.count > 0 {
            totalPrice.text = "$" + " " + String(viewModel.cartPhonePricesTuple.0 + viewModel.cartPhonePricesTuple.1)
            viewModel.dataStorage?.inCart = true
        } else if viewModel.cartPhonesModel.count == 0 {
            totalPrice.text = "$" + " " + "0"
            viewModel.dataStorage?.inCart = false
        }
    }
    
}



//MARK: - Delegate, DataSource
extension MyCartVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel?.cartPhonesModel.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCartCell.identifire, for: indexPath) as! MyCartCell
        cell.delegate = self
        cell.tableView = tableView
        if let cellModel = viewModel?.getMyCartCellViewModel(at: indexPath) {
            cell.viewModel = cellModel
            
            cell.stepper.updatePriceClosure = { [weak self] value in
                cell.updatePrice(by: value)
                // если число вещей 0, то они удаляются из таблицы
                if value == 0 {
                    self?.viewModel?.cartPhonesModel.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                // считаем тотал
                if let phonesPrice = cell.phonePriceLabel.text {
                    self?.viewModel?.countTotal(string: phonesPrice, at: indexPath)
                    self?.totalPriceObserver = 0.0
                }
                
               
            }
        }
       
        return cell
    }
    
    
    
}

//MARK: - SetupUI
extension MyCartVC {
    
    func setupUI() {
        view.backgroundColor = .white
        
        //MARK: Setting NavBar/ TopView
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42).isActive = true
        
        view.addSubview(addressButton)
        addressButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        addressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        view.addSubview(addAdressLabel)
        addAdressLabel.centerYAnchor.constraint(equalTo: addressButton.centerYAnchor).isActive = true
        addAdressLabel.trailingAnchor.constraint(equalTo: addressButton.leadingAnchor, constant: -9).isActive = true
        
        view.addSubview(myCartLabel)
        myCartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42).isActive = true
        myCartLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        
 
        
        //MARK: Setting CardView and TableView
        view.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: myCartLabel.bottomAnchor, constant: 49).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(checkoutButton)
        checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        view.addSubview(lineUpper)
        lineUpper.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lineUpper.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -27).isActive = true
        lineUpper.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        
        view.addSubview(tableView)
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: lineUpper.topAnchor).isActive = true

        view.addSubview(lineLower)
        lineLower.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lineLower.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -118).isActive = true
        lineLower.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        
        StackTotalPrice.addArrangedSubview(totalLabel)
        StackTotalPrice.setCustomSpacing(190, after: totalLabel)
        StackTotalPrice.addArrangedSubview(totalPrice)
        
        view.addSubview(StackTotalPrice)
        StackTotalPrice.topAnchor.constraint(equalTo: lineLower.bottomAnchor, constant: 15).isActive = true
        StackTotalPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55).isActive = true
        StackTotalPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        
        StackDeliveryCost.addArrangedSubview(deliveryLabel)
        StackDeliveryCost.addArrangedSubview(deliveryPrice)
        
        view.addSubview(StackDeliveryCost)
        StackDeliveryCost.topAnchor.constraint(equalTo: StackTotalPrice.bottomAnchor, constant: 15).isActive = true
        StackDeliveryCost.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55).isActive = true
        StackDeliveryCost.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        
    }
}


private extension MyCartVC {
    // Конфигурация для кнопки Check out
    func configureButton(button: UIButton) {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.background.backgroundColor = UIColor(named: "customOrange")
        config.imagePlacement = .leading
        config.imagePadding = 5
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
          var outgoing = incoming
          outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
          return outgoing
        }
        button.configuration = config
        button.configurationUpdateHandler = { [weak self] button in
          // 1
          var config = button.configuration
          // 2
            config?.showsActivityIndicator = self!.checkingOut
          // 3
            config?.title = self!.checkingOut ? "Checking Out..." : "Checkout"
          // 4
            button.isEnabled = !self!.checkingOut
          // 5
          button.configuration = config
        }
        button.setNeedsUpdateConfiguration()
    }
}

//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        MyCartVC().showPreview()
//    }
//}
