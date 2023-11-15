
import Foundation
import UIKit

class SearchBar: UITextField {
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchBar()
        configureImageInSearchBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Left View Customization
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 15 // Увеличение отступа слева
        return rect
    }
        
    // MARK: - Text Field Rect Overrides
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 36, dy: 0)
        }
    }

    // MARK: - UITextFieldDelegate

    extension SearchBar: UITextFieldDelegate {
        // Можно добавить нужные методы делегата, если требуется
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                textField.resignFirstResponder() // Закрываем клавиатуру при нажатии на Return
                return true
            }
    }

    // MARK: - Setup Methods

extension SearchBar {
    
    func configureSearchBar() {
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
    }
    
    func configureImageInSearchBar() {
        let image = UIImage(named: "search")
        leftView = UIImageView(image: image)
        leftView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftViewMode = .always
    }
    
}
