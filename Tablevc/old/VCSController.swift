//
//  IHYLVCController.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/18/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation

public protocol VCSController {
    var mainVC: VCSViewOrVC { get }
    func willAttach()
    func willDeattach()
    func didAttach()
    func didDeattach()
}

public extension VCSController {
    func equals(_ second: VCSController) -> Bool {
        return self.mainVC.equals(second.mainVC)
    }
    func sameClass(_ second: VCSController) -> Bool {
        return object_getClassName(self) == object_getClassName(second)
    }
}

public extension VCSController {
    func willAttach() {
        
    }
    
    func willDeattach() {
        
    }
    
    func didAttach() {
        
    }
    
    func didDeattach() {
        
    }
}

extension UIViewController: VCSController {
    public var mainVC: VCSViewOrVC {
        return self
    }
}

extension UIView: VCSController {
    public var mainVC: VCSViewOrVC {
        return self
    }
}
