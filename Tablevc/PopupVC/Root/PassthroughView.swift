//
//  PassthroughView.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 4/13/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class PassthroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in self.subviews {
            if (!view.isHidden && view.isUserInteractionEnabled && view.point(inside: self.convert(point, to: view), with: event)) {
                return true
            }
        }
        return false
    }
}
