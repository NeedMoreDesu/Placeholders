//
//  AnyCell.swift
//  Containers
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

public protocol AnyTableViewCell {
    func registerReuseId(reuseId: String, tableView: UITableView)
    func reuseCell(cell: UITableViewCell) -> AnyTableViewCell?
}

extension UIViewController: AnyTableViewCell {
    public func registerReuseId(reuseId: String, tableView: UITableView) {
        let type = VCSTableViewCell.self
        let bundle = Bundle(for: type)
        let nib = UINib(nibName: "VSCTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
    
    public func reuseCell(cell: UITableViewCell) -> AnyTableViewCell? {
        return (cell as? VSCTableViewCell).insertedVC
    }
}

extension UIView: AnyTableViewCell {
    public func registerReuseId(reuseId: String, tableView: UITableView) {
        let type = VCSTableViewCell.self
        let bundle = Bundle(for: type)
        let nib = UINib(nibName: "VSCTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
}
