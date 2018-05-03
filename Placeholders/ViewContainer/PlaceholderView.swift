//
//  ContainerView.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

open class PlaceholderView: PassthroughView {
    open weak var controllingVC: UIViewController? // can be set from outside
    private var containerVC: UIViewController? {
        return self.controllingVC ?? PlaceholderUtils.controllingViewController(view: self)
    }
    
    open var insertedView: AnyView? {
        didSet {
            guard let newValue = self.insertedView else {
                return
            }
            if let oldValue = oldValue, newValue.view == oldValue.view {
                return
            }
            oldValue?.remove()
            newValue.add(to: self.containerVC, into: self)
        }
    }
    open func vc<Type>(type: Type.Type? = nil) -> Type {
        return self.insertedView as! Type
    }
    
    deinit {
        self.insertedView?.remove()
    }
}
