//
//  PopupVC.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 4/13/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {
    public var popupWindow: UIWindow!
    
    func show() {
        self.popupWindow = PassthroughWindow(frame: UIScreen.main.bounds)
        let rootVC = PopupRootVC.create()
        self.popupWindow.rootViewController = rootVC
        self.popupWindow.windowLevel = UIWindowLevelAlert+10
        self.popupWindow.isHidden = false
        
        rootVC.addChildViewController(self)
        rootVC.view.addSubview(self.view)
        self.view.frame = rootVC.view.frame
    }
    
    func dismiss() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        self.popupWindow.isHidden = true
        self.popupWindow = nil
    }
}
