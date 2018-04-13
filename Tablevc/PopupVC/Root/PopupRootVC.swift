//
//  PopupRootVC.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 4/13/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class PopupRootVC: UIViewController {
    class func create() -> PopupRootVC {
        return ContainersUtils.createVC(storyboardId: "PopupRoot", vcId: "PopupRootVC")
    }
}
