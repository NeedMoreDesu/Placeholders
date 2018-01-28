//
//  ContainerView.swift
//  Containers
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

open class ContainerView: UIView {
    var controllingVC: UIViewController {
        return ContainersUtils.controllingViewController(view: self)
    }
    
    open var insertedView: AnyView? {
        didSet {
            guard let newValue = self.insertedView else {
                return
            }
            if let oldValue = oldValue, newValue.equals(oldValue) {
                return
            }
            oldValue?.remove()
            newValue.add(to: self.controllingVC, into: self)
        }
    }
    open func vc<Type>(type: Type.Type? = nil) -> Type {
        return self.insertedView?.mainVC as! Type
    }
    
    deinit {
        self.insertedView?.remove()
    }
    
    //MARK: inner stuff
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
