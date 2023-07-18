

import Foundation
import UIKit
import SwiftUI


class MyCartVC : UIViewController {
    
    let viewModel = MyCartViewModel()
    // проперти для кнопки, если true, то она грузится, если false, то просто Чекаут
    //var checkingOut = false
    
    var checkingOut : Bool {
        checkoutButton.isTouchInside ? true : false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        tableView.register(MyCartCell.self, forCellReuseIdentifier: MyCartCell.identifire)
        
        navigationItem.hidesBackButton = true
        backButtonSetup()
        
        initViewModel()
        }
    
    func initViewModel() {
        viewModel.getCartPhones()
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
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
        return but
    }()
    
    @objc func handlePresentingVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func backButtonSetup() {
        backButton.addTarget(self, action: #selector(handlePresentingVC), for: .touchUpInside)
        let backBarButtonItems = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItems
    }
    
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
    
     lazy var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .customDarkBlue
        table.layer.cornerRadius = 15
        table.dataSource = self
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // округляет только левый верхний и правый углы через cornerRadius
        table.clipsToBounds = true
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

    func createLabel (text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }
    
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
        
        // giving a config to style our button
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
        return button
    }()
    
    func setupUI() {
        view.backgroundColor = .white
        
        //MARK: - Setting NavBar/ TopView
        view.addSubview(backButton)
        view.addSubview(addressButton)
        view.addSubview(addAdressLabel)
        view.addSubview(myCartLabel)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            
            addressButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            addressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            addAdressLabel.centerYAnchor.constraint(equalTo: addressButton.centerYAnchor),
            addAdressLabel.trailingAnchor.constraint(equalTo: addressButton.leadingAnchor, constant: -9),
            
            myCartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            myCartLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 180)])
        
        //MARK: - Setting CardView and TableView
        view.addSubview(cardView)
        view.addSubview(tableView)
        view.addSubview(lineUpper)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: myCartLabel.bottomAnchor, constant: 49),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: lineUpper.topAnchor),
            ])
        
        //MARK: - Setting block with lines, Total, Delivery label
        
        view.addSubview(lineLower)

        // тут стакВью идут
        view.addSubview(StackTotalPrice)
        view.addSubview(StackDeliveryCost)
        
        //view.addSubview(lineLower)
        
        view.addSubview(checkoutButton)
        
        let total = createLabel(text: "Total", font: .markProFont(size: 14, weight: .plain)!)
        let totalPrice = createLabel(text: "$6,000 us", font: .markProFont(size: 14, weight: .medium)!)
        StackTotalPrice.addArrangedSubview(total)
        StackTotalPrice.setCustomSpacing(190, after: total)
        StackTotalPrice.addArrangedSubview(totalPrice)
        
        let deliveryLabel = createLabel(text: "Delivery", font: .markProFont(size: 14, weight: .plain)!)
        let deliveryPrice = createLabel(text: "Free", font: .markProFont(size: 14, weight: .medium)!)
        
        StackDeliveryCost.addArrangedSubview(deliveryLabel)
        StackDeliveryCost.addArrangedSubview(deliveryPrice)
        
    
        NSLayoutConstraint.activate([
            lineUpper.widthAnchor.constraint(equalTo: view.widthAnchor),
            lineUpper.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -27),
            lineUpper.heightAnchor.constraint(equalToConstant: 0.2),
          
            StackTotalPrice.topAnchor.constraint(equalTo: lineLower.bottomAnchor, constant: 15),
            StackTotalPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            StackTotalPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            StackDeliveryCost.topAnchor.constraint(equalTo: StackTotalPrice.bottomAnchor, constant: 15),
            StackDeliveryCost.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            StackDeliveryCost.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            lineLower.widthAnchor.constraint(equalTo: view.widthAnchor),
            lineLower.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -118),
            lineLower.heightAnchor.constraint(equalToConstant: 0.2),
            
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77),
            checkoutButton.heightAnchor.constraint(equalToConstant: 54),
        ])
        
    }
}




//MARK: - Delegate, DataSource
extension MyCartVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartPhonesModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCartCell.identifire, for: indexPath) as! MyCartCell
        cell.clipsToBounds = true
        cell.stepper.updatePriceClosure = { [weak self] value in
            cell.updatePrice(by: value)
        }
        
        if let cellModel = viewModel.getMyCartCellViewModel(at: indexPath) {
            cell.viewModel = cellModel
        }
        return cell
    }
}


struct ViewControllerProvider : PreviewProvider {
    static var previews: some View {
        MyCartVC().showPreview()
    }
}
