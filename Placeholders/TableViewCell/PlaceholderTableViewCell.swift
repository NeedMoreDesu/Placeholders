//
//  PlaceholdersTableViewCell.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

class PlaceholderTableViewCell: UITableViewCell {
    //MARK: cell creation
    class func registerReuseId(reuseId: String, tableView: UITableView) {
        let type = PlaceholderTableViewCell.self
        let bundle = Bundle(for: type)
        let nib = UINib(nibName: "PlaceholderTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
    
    //MARK: public
    open weak var controllingVC: UIViewController? // must be set from outside
    private var containerVC: UIViewController? {
        return self.controllingVC!
    }
    open var insertedView: AnyView? {
        didSet {
            guard let newValue = self.insertedView else {
                return
            }
            if let oldValue = oldValue, newValue.asView == oldValue.asView {
                return
            }
            oldValue?.remove()
            newValue.add(to: self.containerVC, into: self)
        }
    }
    open func vc<Type>(type: Type.Type? = nil) -> Type {
        return self.insertedView as! Type
    }
    
    deinit {
        self.insertedView?.remove()
    }
}
