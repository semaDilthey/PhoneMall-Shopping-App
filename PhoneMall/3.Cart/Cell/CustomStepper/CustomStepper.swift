
import Foundation
import UIKit

// протокол сообщающийся между кнопкой и лейблом
protocol StepperDelegate {
    func increaseNumber(stepper: CustomStepper, by number: Int)
    func decreaseNumber(cell: CustomStepper, by number: Int)
}


class CustomStepper : UIView {
    
    init() {
        super.init(frame: .zero)   // тут же ставим его без рамок
        setup()
        counterInProgress()
    }
    
    var updatePriceClosure: ((Int) -> Void)?
    
    var delegate : StepperDelegate? // делегируем
    
    var viewModel: MyCartCellModelProtocol?
    
    var counter: String = "1" {
           didSet {
               countLabel.text = counter
           }
       }
           
   private let plusButton: UIButton = {
       let button = UIButton()
       button.setTitle("+", for: .normal)
       button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
   
   private let minusButton: UIButton = {
       let button = UIButton()
       button.setTitle("−", for: .normal)
       button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
  
   private let countLabel: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.textAlignment = .center
       label.font = UIFont.markProFont(size: 20, weight: .medium)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    
    //MARK:  Работа с функциями кнопок и counter-ом
    @objc func decreaseFunc() {
     changeQuantity(by: -1)
     }
    
    @objc func increaseFunc() {
     changeQuantity(by: 1)
     }
     
     // считает число для counter, увеличивает или уменьшает его
     func changeQuantity(by amount: Int) {
         var quantity = Int(counter)!
         quantity += amount
         let minValue = 0
     if quantity < minValue {
     quantity = 0
         counter = "0"
     } else {
         counter = "\(quantity)"
         updatePriceClosure?(quantity)
     }
     delegate?.decreaseNumber(cell: self, by: quantity)
     }
    //
    // ну и сама функция, которая дает нашим кнопкам действия
    func counterInProgress() {
    plusButton.addTarget(self, action: #selector(increaseFunc), for: .touchUpInside)
    minusButton.addTarget(self, action: #selector(decreaseFunc), for: .touchUpInside)
    }
     
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
}

//MARK: - SetupUI

extension CustomStepper {
    
    private func setup() {
           backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 67/255, alpha: 1)
           
           addSubview(minusButton)
                minusButton.anchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: nil,
                                   trailing: trailingAnchor,
                                   padding: UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0))
                minusButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        
        addSubview(plusButton)
             plusButton.anchor(top: nil,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
             plusButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        
           addSubview(countLabel)
                countLabel.anchor(top: minusButton.bottomAnchor,
                                  leading: leadingAnchor,
                                  bottom: plusButton.topAnchor,
                                  trailing: trailingAnchor)
                
           
    }
           
}
