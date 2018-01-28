//
//  VCSTableViewCell.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

class VCSTableViewCell: UITableViewCell {
    //MARK: cell creation
    class func create(tableView: UITableView, reuseID: String, indexPath: IndexPath) -> VCSTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! VCSTableViewCell
        cell.tableView = tableView

        return cell
    }
    
    //MARK: public
    weak var tableView: UITableView?
    weak var parentVC: UIViewController?
    
    public var insertedController: VCSController? {
        didSet {
            guard let newValue = self.insertedController else {
                return
            }
            if let oldValue = oldValue, newValue.equals(oldValue) {
                return
            }
            self.unconnectVC(vc: oldValue)
            try! self.connectVC(vc: insertedController)
        }
    }
    func vc<Type>(type: Type.Type? = nil) -> Type {
        return self.insertedController?.mainVC as! Type
    }
    
    deinit {
        self.unconnectVC(vc: self.insertedController)
    }
    
    //MARK: inner stuff
    private func connectVC(vc: VCSController?) throws {
        guard let tableView = self.tableView else {
            throw VCSError.tableViewNotSet
        }
        guard let controllingVC = self.parentVC ?? VCSUtils.viewController(view: tableView) else {
            throw VCSError.parentVCnotFound
        }
        if let insertedController = vc,
            let insertedVC = insertedController.mainVC.asVC {
            insertedController.willAttach()
            VCSUtils.addVC(toVc: controllingVC, fromVC: insertedVC, toContainerView: self)
            insertedController.willDeattach()
        }
        if let insertedController = vc,
            let insertedView = insertedController.mainVC.asView {
            insertedController.willAttach()
            VCSUtils.addView(toView: self, fromView: insertedView)
            insertedController.willDeattach()
        }
    }
    
    private func unconnectVC(vc: VCSController?) {
        if let insertedController = vc,
            let insertedVC = insertedController.mainVC.asVC {
            insertedController.willDeattach()
            VCSUtils.removeVC(vc: insertedVC)
            insertedController.didDeattach()
        }
        if let insertedController = vc,
            let insertedView = insertedController.mainVC.asView {
            insertedController.willDeattach()
            insertedView.removeFromSuperview()
            insertedController.didDeattach()
        }
    }
}
