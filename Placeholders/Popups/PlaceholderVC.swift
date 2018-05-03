//
//  PopupRootVC.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 4/13/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

open class PlaceholderVC: UIViewController {
    //MARK: VC creation
    public class func create() -> PlaceholderVC {
        return PlaceholderUtils.createVC(storyboardId: "PlaceholderVC", vcId: "PlaceholderVC")
    }
    
    public var placeholder: PlaceholderView {
        return self.view as! PlaceholderView
    }

    //MARK:- popup methods
    public var popupWindow: UIWindow!

    public func showPopup(level: UIWindowLevel = UIWindowLevelAlert+10) {
        self.popupWindow = PassthroughWindow(frame: UIScreen.main.bounds)
        self.popupWindow.rootViewController = self
        self.popupWindow.windowLevel = level
        self.popupWindow.isHidden = false
    }
    
    public func dismissPopup() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        self.popupWindow.isHidden = true
        self.popupWindow = nil
    }
}

