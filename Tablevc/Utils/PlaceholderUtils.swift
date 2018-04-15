//
//  PlaceholderUtils.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/27/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

class PlaceholderUtils {
    public class func controllingViewController(view: UIView?) -> UIViewController? {
        var responder: UIResponder? = view
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return responder as? UIViewController
    }
    
    public class func addContainerConstraints(container: UIView, view: UIView) {
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
    
    public class func createVC<Type>(storyboardId: String, vcId: String) -> Type {
        let type = Type.self as! AnyClass
        let bundle = Bundle(for: type)
        let storyboard = UIStoryboard.init(name: storyboardId, bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: vcId)
        
        return vc as! Type
    }
    
    public class func afterDelay(seconds: Double, fn: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            fn()
        }
    }
}
