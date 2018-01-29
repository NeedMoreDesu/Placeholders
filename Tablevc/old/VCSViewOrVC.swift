////
////  VCSViewOrVC.swift
////  ViewControllerSubviews
////
////  Created by Oleksii Horishnii on 10/2/17.
////  Copyright © 2017 Oleksii Horishnii. All rights reserved.
////
//
//import Foundation
//
//public protocol VCSViewOrVC {
//    var asVC: UIViewController? { get }
//    var asView: UIView? { get }
//}
//public extension VCSViewOrVC {
//    func equals(_ second: VCSViewOrVC) -> Bool {
//        if self.asVC != nil {
//            return self.asVC == second.asVC
//        } else if self.asView != nil {
//            return self.asView == second.asView
//        }
//        return false
//    }
//}
//
//extension UIViewController: VCSViewOrVC {
//    public var asVC: UIViewController? {
//        return self
//    }
//    public var asView: UIView? {
//        return nil
//    }
//}
//
//extension UIView: VCSViewOrVC {
//    public var asVC: UIViewController? {
//        return nil
//    }
//    public var asView: UIView? {
//        return self
//    }
//}

