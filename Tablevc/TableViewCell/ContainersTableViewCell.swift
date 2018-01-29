//
//  ContainersTableViewCell.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

class ContainersTableViewCell: UITableViewCell {
    //MARK: cell creation
    class func reuseCell(tableView: UITableView, reuseID: String, indexPath: IndexPath) -> ContainersTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! ContainersTableViewCell
        cell.tableView = tableView

        return cell
    }
    class func registerReuseId(reuseId: String, tableView: UITableView) {
        let type = VCSTableViewCell.self
        let bundle = Bundle(for: type)
        let nib = UINib(nibName: "ContainersTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
    
    //MARK: public
    weak var tableView: UITableView?
    weak var parentVC: UIViewController?
    var controllingVC: UIViewController? {
        return self.parentVC ?? ContainersUtils.controllingViewController(view: self.tableView!)!
    }
    
    open var insertedView: AnyView? {
        didSet {
            guard let newValue = self.insertedView else {
                return
            }
            if let oldValue = oldValue, newValue.view == oldValue.view {
                return
            }
            oldValue?.remove()
            newValue.add(to: self.controllingVC, into: self)
        }
    }
    open func vc<Type>(type: Type.Type? = nil) -> Type {
        return self.insertedView as! Type
    }
    
    deinit {
        self.insertedView?.remove()
    }
}
