//
//  SearchBar.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 24.06.2023.
//
import Foundation
import UIKit

class SearchBar: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        placeholder = "Search..."
        font = UIFont.markProFont(size: 11, weight: .plain)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 22
        layer.masksToBounds = true
        textColor = .black
        
        let image = UIImage(named: "search")
        leftView = UIImageView(image: image)
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchBar: UITextFieldDelegate {
    

}
