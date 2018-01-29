//
//  AnyCell.swift
//  Containers
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

@objc
public protocol AnyTableViewCell {
    static func registerReuseId(reuseId: String, tableView: UITableView)
    static func reuseCell(cell: UITableViewCell) -> AnyTableViewCell
    static func create() -> AnyView?
}

extension AnyTableViewCell {
    @objc public static func create() -> AnyView? {
        return nil
    }
}

extension UIViewController: AnyTableViewCell {
    public static func registerReuseId(reuseId: String, tableView: UITableView) {
        ContainersTableViewCell.registerReuseId(reuseId: reuseId, tableView: tableView)
    }
    
    public static func reuseCell(cell: UITableViewCell) -> AnyTableViewCell {
        let cell = ContainersTableViewCell.reuseCell(cell: cell)
        cell.insertedView = cell.insertedView ?? self.create()
        return cell.insertedView
    }
}

extension UIView: AnyTableViewCell {
    public static func registerReuseId(reuseId: String, tableView: UITableView) {
        ContainersTableViewCell.registerReuseId(reuseId: reuseId, tableView: tableView)
    }
    
    public static func reuseCell(cell: UITableViewCell) -> AnyTableViewCell {
        let cell = ContainersTableViewCell.reuseCell(cell: cell)
        cell.insertedView = cell.insertedView ?? self.create()
        return cell.insertedView
    }
}
