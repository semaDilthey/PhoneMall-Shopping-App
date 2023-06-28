//
//  FilterViewController.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation
import UIKit

class FilterViewController : UIPresentationController {
    var blurEffectView = UIVisualEffectView()
    var tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView!.layer.cornerRadius = 10
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        self.presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismiss(){
            self.presentedViewController.dismiss(animated: true, completion: nil)
        }
    
    override var frameOfPresentedViewInContainerView: CGRect{
            return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height/2), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height/2))
        }
        override func dismissalTransitionWillBegin() {
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
                self.blurEffectView.alpha = 0
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in
                self.blurEffectView.removeFromSuperview()
            })
        }
    
        override func presentationTransitionWillBegin() {
            self.blurEffectView.alpha = 0
            self.containerView?.addSubview(blurEffectView)
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
                self.blurEffectView.alpha = 1
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in

            })
        }
}

extension UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return FilterViewController(presentedViewController: presented, presenting: presenting)
    }
    
}
