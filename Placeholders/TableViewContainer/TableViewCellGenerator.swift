//
//  TableViewCellGenerator.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

/*
 Adapt all CellGenerators to be able to produce UITableView cells
*/
public protocol TableViewCellGenerator {
    var reuseId: String { get }
    func registerReuseId(tableView: UITableView)
    func updateCell(cell: UITableViewCell, vc: UIViewController)
}

extension CellGenerator.View: TableViewCellGenerator {
    public func registerReuseId(tableView: UITableView) {
        PlaceholderTableViewCell.registerReuseId(reuseId: self.reuseId, tableView: tableView)
    }
    
    public func updateCell(cell: UITableViewCell, vc: UIViewController) {
        if let cell = cell as? PlaceholderTableViewCell {
            if cell.insertedView == nil {
                cell.controllingVC = vc
                cell.insertedView = self.create()
            }
            self.update(cell.insertedView!, vc)
        }
    }
}

extension CellGenerator.Xib: TableViewCellGenerator {
    public func registerReuseId(tableView: UITableView) {
        tableView.register(self.nib, forCellReuseIdentifier: self.reuseId)
    }
    
    public func updateCell(cell: UITableViewCell, vc: UIViewController) {
        self.update(cell, vc)
    }
}

extension CellGenerator.Static: TableViewCellGenerator {
    public func registerReuseId(tableView: UITableView) {
        PlaceholderTableViewCell.registerReuseId(reuseId: self.reuseId, tableView: tableView)
    }
    
    public func updateCell(cell: UITableViewCell, vc: UIViewController) {
        if let cell = cell as? PlaceholderTableViewCell {
            cell.controllingVC = vc
            cell.insertedView = get(vc)
        }
    }
}
