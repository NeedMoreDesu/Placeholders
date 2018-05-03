//
//  PassthroughView.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 4/15/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

open class PassthroughView: UIView {
    public var isPassthrough = true
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (!self.isPassthrough) {
            return true
        }
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
