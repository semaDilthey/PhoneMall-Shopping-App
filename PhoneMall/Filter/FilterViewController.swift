//
//  FilterViewController.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation
import UIKit
import SwiftUI

class FilterViewController : UIViewController {
    
    var viewModel = FilterViewModel()
    
    var filterData = FilterData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .snowyWhite
        setupUI()
        setUpPickers()
    }
    
    func set() {
        label.text = viewModel.title
    }
    
    private lazy var closeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customDarkBlue
        button.setImage(UIImage(named: "x"), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTappedClose), for: .touchUpInside)
        return button
    }()
    
    @objc func didTappedClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private lazy var doneButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customOrange
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.markProFont(size: 20, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTappedDone), for: .touchUpInside)
        return button
    }()
    
    @objc func didTappedDone() {
        self.dismiss(animated: true, completion: nil)
    }
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        label.font = .markProFont(size: 20, weight: .medium)
        return label
    }()
    
    lazy var pricePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var priceTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.text = "Select price"
        textField.inputView = pricePicker
        textField.font = UIFont.markProFont(size: 20, weight: .plain)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.textColor = UIColor.gray.withAlphaComponent(0.5)
        textField.tintColor = .clear
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = .markProFont(size: 20, weight: .medium)
        return label
    }()
    
    lazy var namePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var nameTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.text = "Select brand"
        textField.inputView = namePicker
        textField.font = UIFont.markProFont(size: 20, weight: .plain)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.textColor = UIColor.gray.withAlphaComponent(0.5)
        textField.tintColor = .clear
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    let sizeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Size"
        label.font = .markProFont(size: 20, weight: .medium)
        return label
    }()
    
    lazy var sizePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var sizeTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.text = "Select size"
        textField.inputView = sizePicker
        textField.font = UIFont.markProFont(size: 20, weight: .plain)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.textColor = UIColor.gray.withAlphaComponent(0.5)
        textField.tintColor = .clear
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Filter options"
        label.font = UIFont.markProFont(size: 20, weight: .medium)
        label.textColor = .customDarkBlue
        return label
    }()
    
}

extension FilterViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let phones = filterData.phoneModels[row]
//        let phones = viewModel.getModels()[row]
        let options = filterData.optionsSortedByModelsId[0]
//        let options = viewModel.getSortedModels()[0]

        switch pickerView {
        case namePicker:
            filterData.optionsSortedByModelsId = viewModel.getOptions(phone_id: phones.id)
            nameTextField.text = phones.name
            nameTextField.resignFirstResponder()
            nameTextField.textColor = .customDarkBlue
            sizePicker.reloadAllComponents()
            pricePicker.reloadAllComponents()
            sizeTextField.text = "Select size"
            priceTextField.text = "Select price"
        case sizePicker:
            sizeTextField.text = String(options.size) + " inches"
            sizeTextField.resignFirstResponder()
            sizeTextField.textColor = .customDarkBlue
        case pricePicker:
            priceTextField.text = String(options.price) + "$"
            priceTextField.resignFirstResponder()
            priceTextField.textColor = .customDarkBlue
        default: return
        }
    }
}


extension FilterViewController : UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let phones = filterData.phoneModels[row]
//        let phones = viewModel.getModels()[row]

        let options = filterData.optionsSortedByModelsId[0]
//        let options = viewModel.getSortedModels()[0]

        switch pickerView {
        case namePicker : return phones.name
        case sizePicker: return String(options.size)
        case pricePicker: return String(options.price)
        default: return nil
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case namePicker : return filterData.phoneModels.count
        case sizePicker : return filterData.optionsSortedByModelsId.count
        case pricePicker : return filterData.optionsSortedByModelsId.count
        default: return 1
        }
    }
}


//MARK: - SetupUI, SetupPickers
extension FilterViewController {
    
    func setUpPickers() {
        pricePicker.dataSource = self
        pricePicker.delegate = self
        sizePicker.dataSource = self
        sizePicker.delegate = self
        namePicker.dataSource = self
        namePicker.delegate = self
    }
    
    func setupUI() {
        
        view.addSubview(closeButton)
        view.addSubview(doneButton)
        view.addSubview(label)
        
        closeButton.anchor(top: view.topAnchor,
                           leading: view.leadingAnchor,
                           bottom: nil,
                           trailing: nil,
                           padding: UIEdgeInsets(top: 24, left: 44, bottom: 0, right: 0),
                           size: CGSize(width: 37, height: 37))
        
        doneButton.anchor(top: view.topAnchor,
                           leading: nil,
                           bottom: nil,
                          trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 20),
                           size: CGSize(width: 86, height: 37))
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor).isActive = true
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        nameLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant:-5).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: -5).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
        
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        priceLabel.leadingAnchor.constraint(equalTo: priceTextField.leadingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5).isActive = true
        
        priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        priceTextField.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor).isActive = true
        priceTextField.trailingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: -5).isActive = true
        priceTextField.heightAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
        
        view.addSubview(sizeLabel)
        view.addSubview(sizeTextField)
        sizeLabel.leadingAnchor.constraint(equalTo: sizeTextField.leadingAnchor).isActive = true
        sizeLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 5).isActive = true
        
        sizeTextField.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 5).isActive = true
        sizeTextField.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor).isActive = true
        sizeTextField.trailingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: -5).isActive = true
        sizeTextField.heightAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
    }
}

//
//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        FilterViewController().showPreview()
//    }
//}
