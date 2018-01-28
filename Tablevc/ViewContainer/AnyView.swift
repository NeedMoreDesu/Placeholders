//
//  AnyView.swift
//  Containers
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

protocol AnyView {
    func add(to: UIViewController, into: UIView)
    func remove()
    var view: UIView { get }
}

extension UIView: AnyView {
    func add(to: UIViewController, into: UIView) {
        into.addSubview(self)
        ContainersUtils.addContainerConstraints(container: into, view: self)
    }
    
    func remove() {
        self.removeFromSuperview()
    }
    
    var view: UIView {
        return self
    }
}

extension UIViewController: AnyView {
    func add(to: UIViewController, into: UIView) {
        to.addChildViewController(self)
        self.view.bounds = into.bounds
        into.addSubview(self.view)
        ContainersUtils.addContainerConstraints(container: into, view: self.view)
        self.didMove(toParentViewController: to)
    }
    
    func remove() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }

    var view: UIView {
        return self.view
    }
}
