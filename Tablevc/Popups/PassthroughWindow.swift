//
//  PassthroughWindow.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 4/13/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

open class PassthroughWindow: UIWindow {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestResult = super.hitTest(point, with: event)
        if hitTestResult?.isKind(of: PassthroughWindow.self) == true {
            return nil
        }
        return hitTestResult
    }
}
