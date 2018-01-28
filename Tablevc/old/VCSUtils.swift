//
//  Utils.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

class VCSUtils {
    class func viewController(view: UIView) -> UIViewController? {
        var responder: UIResponder? = view
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return responder as? UIViewController
    }
    
    class func addContainerConstraints(container: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view,
                           attribute: NSLayoutAttribute.leading,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: container,
                           attribute: NSLayoutAttribute.leading,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: view,
                           attribute: NSLayoutAttribute.trailing,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: container,
                           attribute: NSLayoutAttribute.trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: view,
                           attribute: NSLayoutAttribute.top,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: container,
                           attribute: NSLayoutAttribute.top,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: view,
                           attribute: NSLayoutAttribute.bottom,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: container,
                           attribute: NSLayoutAttribute.bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
    }
    
    class func addVC(toVc:UIViewController,
                     fromVC:UIViewController,
                     toContainerView containerView:UIView? = nil,
                     viewToInsert:UIView? = nil) {
        let toView: UIView = containerView ?? toVc.view
        let view: UIView = viewToInsert ?? fromVC.view
        toVc.addChildViewController(fromVC)
        toView.addSubview(view)
        fromVC.didMove(toParentViewController: toVc)
        addContainerConstraints(container: toView, view: view)
    }

    class func addView(toView:UIView,
                       fromView:UIView) {
        toView.addSubview(fromView)
        addContainerConstraints(container: toView, view: fromView)
    }
    
    class func removeVC(vc: UIViewController,
                        viewToInsert:UIView? = nil) {
        let view: UIView = viewToInsert ?? vc.view
        
        vc.willMove(toParentViewController: nil)
        view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    class func createVC<Type>(storyboardId: String, vcId: String) throws -> Type {
        if (storyboardId == "") {
            throw VCSError.storyboardIdIsEmpty
        }
        if (vcId == "") {
            throw VCSError.vcIdIsEmpty
        }
        var storyboard: UIStoryboard!
        do {
            try VCSObjC.catchException({
                let type = Type.self as! AnyClass
                let bundle = Bundle(for: type)
                storyboard = UIStoryboard.init(name: storyboardId, bundle: bundle)
            })
        } catch _ {
            throw VCSError.wrongStoryboardId
        }
        var vc: UIViewController!
        do {
            try VCSObjC.catchException({
                vc = storyboard.instantiateViewController(withIdentifier: vcId)
            })
        } catch _ {
            throw VCSError.wrongVcId
        }
        
        if let vc = vc as? Type {
            return vc
        } else {
            throw VCSError.viewControllerTypeMismatch
        }
    }
    
    class func afterDelay(seconds: Double, fn: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            fn()
        }
    }
}
