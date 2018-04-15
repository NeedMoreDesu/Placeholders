//
//  AnyView+popups.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 4/15/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

extension AnyView {
    func showPopup(level: UIWindowLevel = UIWindowLevelAlert+10) -> PlaceholderVC {
        let popup = PlaceholderVC.create()
        popup.placeholder.insertedView = self.view
        popup.showPopup(level: level)
        return popup
    }
}
