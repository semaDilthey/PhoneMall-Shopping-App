

import Foundation
import UIKit
import SwiftUI



class MyCartVC : UIViewController {
    
    // проперти для кнопки, если true, то она грузится, если false, то просто Чекаут
    //var checkingOut = false
    
    var checkingOut : Bool {
        checkoutButton.isTouchInside ? true : false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        tableView.register(MyCartVCTableViewCell.self, forCellReuseIdentifier: MyCartVCTableViewCell.identifire)
        
        navigationItem.hidesBackButton = true
        backButtonSetup()
        }
    
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
        label.font = UIFont(name: "DSLCLU+MarkPro-Heavy", size: 30)
        label.textColor = UIColor(named: "customDarkBlue")
        return label
    }()
    
    lazy var scrollView : UIView = { // non scrollable, just view
        let scroll = UIView()
        scroll.backgroundColor = UIColor(named: "customDarkBlue")
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.clipsToBounds = true
        scroll.layer.cornerRadius = 15
        return scroll
    }()
    
    lazy var checkoutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "customOrange")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "DSLCLU+MarkPro-Medium", size: 20)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
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
    
    private let lineLabel1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineLabel2 : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let stackView1 : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let stackView2 : UIStackView = {
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

    
    @objc func handlePresentingVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func backButtonSetup() {
        backButton.addTarget(self, action: #selector(handlePresentingVC), for: .touchUpInside)
        let backBarButtonItems = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItems
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(addressButton)
        view.addSubview(addAdressLabel)
        view.addSubview(myCartLabel)
        view.addSubview(scrollView)
        view.addSubview(checkoutButton)
        view.addSubview(lineLabel1)
        view.addSubview(lineLabel2)
        view.addSubview(tableView)

        // тут стакВью идут
        // ----------------------------------------------------------------------------------------------------------------
        view.addSubview(stackView1)
        view.addSubview(stackView2)
        
        let labelTotal1 = createLabel(text: "Total", font: .markProFont(size: 14, weight: .plain)!)
        let labelPrice1 = createLabel(text: "$6,000 us", font: .markProFont(size: 14, weight: .medium)!)
        stackView1.addArrangedSubview(labelTotal1)
        stackView1.setCustomSpacing(190, after: labelTotal1)
        stackView1.addArrangedSubview(labelPrice1)
        
        let labetDelivery2 = createLabel(text: "Delivery", font: .markProFont(size: 14, weight: .plain)!)
        let labelPrice2 = createLabel(text: "Free", font: .markProFont(size: 14, weight: .medium)!)
        stackView2.addArrangedSubview(labetDelivery2)
        stackView2.addArrangedSubview(labelPrice2)
        //-------------------------------------------------------------
        
    
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            
            addressButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            addressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            addAdressLabel.centerYAnchor.constraint(equalTo: addressButton.centerYAnchor),
            addAdressLabel.trailingAnchor.constraint(equalTo: addressButton.leadingAnchor, constant: -9),
            
            
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15), // to my (equalTo: myCartLabel.bottomAnchor, constant: 49)
            tableView.bottomAnchor.constraint(equalTo: lineLabel2.topAnchor),
            
            myCartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            myCartLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            
            scrollView.topAnchor.constraint(equalTo: myCartLabel.bottomAnchor, constant: 49),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77),
            checkoutButton.heightAnchor.constraint(equalToConstant: 54),
            
            lineLabel1.widthAnchor.constraint(equalTo: view.widthAnchor),
            lineLabel1.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -27),
            lineLabel1.heightAnchor.constraint(equalToConstant: 0.2),
            
            lineLabel2.widthAnchor.constraint(equalTo: view.widthAnchor),
            lineLabel2.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -118),
            lineLabel2.heightAnchor.constraint(equalToConstant: 0.2),
            
            stackView1.topAnchor.constraint(equalTo: lineLabel2.bottomAnchor, constant: 15),
            stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            stackView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 15),
            stackView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
        ])
        
    }
}

//MARK: - Delegate, DataSource
extension MyCartVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCartVCTableViewCell.identifire, for: indexPath) as! MyCartVCTableViewCell
        cell.clipsToBounds = true
        return cell
    }
}


//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        MyCartVC().showPreview()
//    }
//}
