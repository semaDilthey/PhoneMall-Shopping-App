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
    
    var viewModel : FilterViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        //self.view = UIView(frame: CGRect(x: 0, y: 500, width: self.view.frame.width, height: 400))
        setupUI()
    }
    
    
    private lazy var closeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customDarkBlue
        button.setImage(UIImage(named: "x"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var doneButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customOrange
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.markProFont(size: 20, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var pricePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var namePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var sizePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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
    
    func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(doneButton)
        view.addSubview(label)
        view.addSubview(pricePicker)
        view.addSubview(namePicker)
        view.addSubview(sizePicker)
        
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
        
        pricePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pricePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        namePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        namePicker.topAnchor.constraint(equalTo: pricePicker.topAnchor, constant: 50).isActive = true
        
        sizePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sizePicker.topAnchor.constraint(equalTo: namePicker.topAnchor, constant: 50).isActive = true
        
        
    }
}






struct ViewControllerProvider : PreviewProvider {
    static var previews: some View {
        FilterViewController().showPreview()
    }
}
